Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB7AEFCE38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxr36-0008VW-6z; Wed, 04 Mar 2026 13:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr2x-0008F7-7N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:34:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr2w-0001BC-0I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772649248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VhhzZZu/s9WYcbs/FFkwtS/qCwkasMLisQS0KTUmYA=;
 b=bTvQ+5Bv1YtGkbcuAyM02MNwTgZj8lcTQfnGPNLUwXopDsUA8jQ6YH665FRYIj2UZT5gY1
 eUCXoVprUig+4Gjje/8DXiopk5OxLtIVsy4aDDo+sr4db5XNKZp1IorUfHj86vTWoVMfmt
 aueTuh0OJWpKN05Z0RRXVk/UPhL7UPY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-WuFWHbRAOHCd7r2I7eL0dg-1; Wed, 04 Mar 2026 13:34:06 -0500
X-MC-Unique: WuFWHbRAOHCd7r2I7eL0dg-1
X-Mimecast-MFC-AGG-ID: WuFWHbRAOHCd7r2I7eL0dg_1772649246
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb3fae6f60so5125173885a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772649246; x=1773254046; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+VhhzZZu/s9WYcbs/FFkwtS/qCwkasMLisQS0KTUmYA=;
 b=F76Oy8PUtI+i+efDsfHi7WN41YJl7XcuHzI/Z06sq2c/6dZslL0zl00YMF/2NVG/Iu
 uzHa/pc392UHXiT4YM2ks/UXotKg/EiVkCAKwE6dZiuhYwTa5xtg0HRBO1uuGGH2hxEA
 ZRW0LJ0/ECCyudgMor1YaQBwOPGSnMTg1SdxPZfvElX8zsCKYSJerYQPdXPR7+DO3QOj
 rlAFlgDiC6LJhLxzxwnGAcJ86ijPbdoy3nHi8yYc4eGhubG20ufPEY5H+1QmuL3MIqlu
 bt4mJrYV6pA9YyBmKcqSxhzQ49+N94pOoYWqk5/2+UvNGJeZ/I9EUbQd8TQhPz75sZ29
 YN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772649246; x=1773254046;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+VhhzZZu/s9WYcbs/FFkwtS/qCwkasMLisQS0KTUmYA=;
 b=h/IUnqZGFmmk3zQ+iaPO5s6BqZyIcKGywkDxZ3u1i51ZlgXH7/R71lKovX5il8EU0w
 jDmtOPGr3eevctJUR3V0I3COAfHBaFeJjJQTfxFQStHH+IWXNImCf1+X484gmMIlWdbc
 PF4UxNFcMlMkorBDAL3Dklk0PW+aq7WKAIi2JyuPuYLtZ0EWv0IRqeCBQw6bSrjpTxJL
 833rzX4YyqHkDHqbBZbPqWe2ygyFrpd/a8QNGw+R0O207zXjtEQnkEh8rrGKlxPiZ9zj
 AHIDn4PvdGNls4IpxyIWi2gjfNAxYrKgGfLcg8HrVXVSOf1siNQbCvQruw0/bIpD+zao
 0iMA==
X-Gm-Message-State: AOJu0Yyjo6M0wwnhWqLwYeF1r9bF437TlBBOGDbGwqtnv+fIl3Bd5Szh
 fxegE+S6ZPV3DlQeVcqSR+snNRpGCBzflckVPxnhFh+R0hv1Zfp0jt31MINNiVj2hxy1NV99oyF
 knTDcGqe0dCxXAxj/mvHQu9g8HP1672DO5YWijmJstJw1SmuTk8AKdRm9
X-Gm-Gg: ATEYQzwF6amzRPfHvKuWtiM0yqsgwFbZsZC7JGiripaEpNqabqpJZKWtX5otm3zvkCp
 S/4L3IqZ1Amr4rfFlZdVuSLOlX38Ah0mG0GJGD8gYruxcOmNSuT3KnZFlLGOH4U85Wz7riIAelF
 REiCgnoVkT+oAbZOKUEXtnlg7h7Az7bdpi2lH56Wza/00gqGrChyTCK44leQltq2+5y3TDjitVn
 em180IIs3iGdTAFdGD4YMueMhv3DmpTIBKhYLXhUkwF9StBkdby3rDCgXjiDka1MownzNU/GGpj
 3gcR2MoYLn0fgIRiGH2LkPZfRa99t2Yeh38PTauKmUjNCCZbt2Y+rHNvTye+hAQFBKdDsGxctzr
 cUYa35wzMRUfEDg==
X-Received: by 2002:a05:620a:410e:b0:8b2:e17a:17e3 with SMTP id
 af79cd13be357-8cd508e2ad6mr805667685a.1.1772649245988; 
 Wed, 04 Mar 2026 10:34:05 -0800 (PST)
X-Received: by 2002:a05:620a:410e:b0:8b2:e17a:17e3 with SMTP id
 af79cd13be357-8cd508e2ad6mr805663785a.1.1772649245440; 
 Wed, 04 Mar 2026 10:34:05 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f926csm1692237185a.32.2026.03.04.10.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:34:04 -0800 (PST)
Date: Wed, 4 Mar 2026 13:33:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 4/7] system/memory: Have memory_region_type() correctly
 describe containers
Message-ID: <aah7EWTyNBndj88U@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-5-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 11:02:22PM +0100, Philippe Mathieu-Daudé wrote:
> MemoryRegion containers are not I/O regions,
> describe them as 'container'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


