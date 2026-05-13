Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D55ACD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGNg-0000D2-3B; Wed, 13 May 2026 16:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGNe-0000CN-94
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGNc-0002iQ-6c
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778704831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49kls876FreYN+DL/yr/COsT9mq3erSuAaTu7Hc27Q0=;
 b=ShoPgLQfL7xyxxBt9PvBpLDYszBzojBbVEFF++uXspZuv4l1pbO4UcZgDkLaMbV5A8gROi
 rrpHzdYQ2FFEtVC4emGMK6ILOoWHCS+AB9UjXQwgtX8Vf3tWBQGQWmjbQfm4g3Ev/WVlVF
 cUOeINXNLztX3mkbCTZBgNQCmrBs2O8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Q2tJI1jINCSDkP7UjcGC3g-1; Wed, 13 May 2026 16:40:28 -0400
X-MC-Unique: Q2tJI1jINCSDkP7UjcGC3g-1
X-Mimecast-MFC-AGG-ID: Q2tJI1jINCSDkP7UjcGC3g_1778704828
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b49424ad88so184427296d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778704828; x=1779309628; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=49kls876FreYN+DL/yr/COsT9mq3erSuAaTu7Hc27Q0=;
 b=O5hE6g7TvvNb4eYLS+mMQJAEdEbYu3c4j3F34rvreSlTi4hVKQJ2nQ70GWp17OX0JC
 hJnCazQ3TkWOso0w4OVsiVLlKlp0qZvyWTSzupt3Aciupt/dQOZvHhxUbwLqAYZme5xT
 LE8qdJ5Auo6NMHTodDVvB46UKoWbljACyKFLR5EwF9lqUKLDxfCWsy/unvDalFHWo5rt
 tQcY5bN3wrHyhVncPZ3z/TmExeGxmn5fGFMduPXwZD0W1kWnKq/3SXey94SvUeyWoREg
 awVor20607zp60f0QQ1vFGfuUEwB+CJvddsN27Z9ZE7ktuKVp/FONmSq26N5p6D5bFVR
 J4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704828; x=1779309628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=49kls876FreYN+DL/yr/COsT9mq3erSuAaTu7Hc27Q0=;
 b=gR/ZftceqyQUB2Nl9RDdPnxY/0Hhpek4M+ToGzWPMqqc0qZcprz0ph7W89mhuNXOlC
 xm/9n5QhvIl3wcrs1Rn2xBgXtQLj9p3LoHIJJfvWPf10XuTyNeITgn8gZgi2pxLwFVeT
 EWty/yU0TZ+FuIFUZvyrBSDmiF11Sjfx3VGe/sC7uydDWf41qqskIOpJIc5g6PAxN7Iy
 3deVFyKutyuAdc4EsZ0A6I+Gc5AZP2GC23bO1MyImvf+0s5SJ9dTDs97Hx43ONEOzN4N
 yqu0FByXnB0XEwdaeWA6uFGzPGX2yJL2c6LMUdUANXASJKncuW562wmQdVBqKbmKqaML
 gPZQ==
X-Gm-Message-State: AOJu0YwDew3bgKXJXSEHvOgw5auoplkt1jVQUfBQe+3iVd6di0um+dsj
 yxJ3k4oGfLd+9lNWb1Qgtl6gu6cPHkLv35JtekzdSHlh2NCayNgQL9yhC7UotgCtcybwR9vO670
 xREbbEISqUdFPIoXch3omCyzyQ0OyT49/6lPHIPOkhntYXdSkEbD9OUQV
X-Gm-Gg: Acq92OGX25saZwUqO17MdW1JPGHh3r/8OaPaSFmftXRxmLfFS2Ga+SOIYnTYvIjgGrQ
 ST/bJDqodCHGYMqcVfKPiIGNu+AB1qJy0amVv+1g5+4+VgDEbirkgETOd4bCWiw6OGbuSGm8nkW
 1lcAsBVsFrGMTKlefx8V2/2kWEslWnQu8ss2BIIqLxoel1TlF755XDXluIQhh/DVAw7Mcbs9ja1
 uiKpTgy9G6ghkXbCaZXfQzlkaL4iihxAcKOaEFnRlo71rQ2O+dFfa7GBdbjfau/6KiL7pid4SZr
 9RQJySafrZVFLCNIPzHS5mtOE+gTSTWi1ZPeo2XL09LJCU2193hUoPcRcoj87DzMbisa81NgjHG
 NlFicmot+STidwcG3U60UPYyAF0ZryYuyuZcTCzMGSdhNuak=
X-Received: by 2002:a05:6214:ca2:b0:89c:d931:62ee with SMTP id
 6a1803df08f44-8c7dfdb9e3fmr74581856d6.34.1778704827859; 
 Wed, 13 May 2026 13:40:27 -0700 (PDT)
X-Received: by 2002:a05:6214:ca2:b0:89c:d931:62ee with SMTP id
 6a1803df08f44-8c7dfdb9e3fmr74581236d6.34.1778704827368; 
 Wed, 13 May 2026 13:40:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908d1d2cfsm5702346d6.15.2026.05.13.13.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:40:26 -0700 (PDT)
Date: Wed, 13 May 2026 16:40:26 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/13] system/ram-discard-manager: implement replay
 via is_populated iteration
Message-ID: <agThupe6-gswOLAd@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-4-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-4-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 04, 2026 at 04:30:10PM +0400, Marc-André Lureau wrote:
> Replace the source-level replay wrappers with a new
> replay_by_populated_state() helper that iterates the section at
> min-granularity, calls is_populated() for each chunk, and aggregates
> consecutive chunks of the same state before invoking the callback.
> 
> This moves the iteration logic from individual sources into the manager,
> preparing for multi-source aggregation where the manager must combine
> state from multiple sources anyway.
> 
> The replay_populated/replay_discarded vtable entries in
> RamDiscardSourceClass are no longer called but remain in the interface
> for now; they will be removed in follow-up commits along with the
> now-dead source implementations.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


