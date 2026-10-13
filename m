Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3655CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiC9-00033w-Sg; Tue, 13 Oct 2026 15:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGiBx-0002qQ-LR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGiBv-0008E8-Ql
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791919778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6oucVaYQ3n5GBgQha9fHF0++QlyXj2T1/qY+5EmTvo=;
 b=ShyNLvu2BOb+xGADqV7r13OPxISRT43hocIl1GREqNvvBUGPxsjLuqwlpNw5s3gbFn56Jp
 4/7Vx0t2w6MKoknAIhxkQ/vovIOfCvqUd/TVfWBz7ct8RnIpLYjMCePhnelDHhf4Cw9S2M
 Q/4/FX9FguNCTJI+dEbvhlWy6FIluS0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-MinrcFoQOOCNuWPAz-R5oA-1; Tue, 13 Oct 2026 19:29:30 +0000
X-MC-Unique: MinrcFoQOOCNuWPAz-R5oA-1
X-Mimecast-MFC-AGG-ID: MinrcFoQOOCNuWPAz-R5oA_1791919770
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5350ec54bf6so70248861cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791919770; x=1792524570; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r6oucVaYQ3n5GBgQha9fHF0++QlyXj2T1/qY+5EmTvo=;
 b=HBV8qTa1QEW2BkLcZ/FFrcW++Xj195303t3CahXrzIuhJsJNDs5ykaWYW+RdP76a31
 vFfAwbNcF99zOeXunJmH1PjipTJipZ8/GfmAo6dGAR1/fW7m8PLQGQM0PF6FJEJj06eR
 7ssaxD/VRYN8JBRVxrro8NwAVRbth55IZybftwc22r1CULXs8ANFXwhdQLq50O/P9jIz
 yZ8cYM651uuVOlGfDv0XzOoN46zG3A6p3+I8akTz1I5GuhtKZV8EWDanTD/ECKaZXBK+
 IuTMeUTR7iXD8SHTIVY4jdnawjNf4ZpTh1s/Lp2i+AW6ELGvtg976YDOd8YktH+90dew
 JLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791919770; x=1792524570;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r6oucVaYQ3n5GBgQha9fHF0++QlyXj2T1/qY+5EmTvo=;
 b=zeEWnuxykj8VT0QEd1gjnwYxRVKg8aFGXOcHlu+bpB+u06329vXZyls0VBvAsIxp3u
 DaX2hi6tiu6lNLKApSm2Gib+2Pz/gsJJrytD+Z2/RE7xvY0mwgIF6y2pC43DymGtEa++
 gb1+Lnew37+U+yZUgNh7GyVGdv/krs/nqiWPau8448UKz65k9x7SOy2PD8kBAm3EVR4Y
 8ejksBseuuBasnlrxki0298ztiwe7fndfvdS0XcT9vliVHSTqvnfDOJ+lYHP4Ug4BuYk
 1uDdEQACFSxUCBh2b2hcBM4YPEKpvsOP3tw31fVsXSR0oKw+Op8+Xg2IkzLjupa6VPqI
 8OZQ==
X-Gm-Message-State: AFq9FYLp3W+Yvnz8Imguw7dc44Oakah5HoOdAJqGIch+d9QDoVkfzQab
 eIyucf6YtIx/F/8eZ69HQUxBh917tTHAdgx8AUrfBr+REMduE5YsURF6i3sSTc8qNtRy440JiTv
 1PUREX7H+eyfMBRxAlgVjoomWGSYGHyhs/0PJ+5he5jiEqfS0sx4cD5t+
X-Gm-Gg: AYBFou2JTzXuJC+eb/PHt/X3JMUWBoY64Gy/uFbS7s45nJtbmEg1pJbrWSYtG6g19Go
 vRE5mokTq3NAK/6KWUQZIX8WfbFJl/AsAxHddYHbk8qR+3QEVXAfZ6uZDaXM3k/WiZ6DMJNY4p1
 anzbT0QoGLUkbIOT+yfk0sUDRes/YO846xY3TVZ0vgCkqU9TGS7sp2HBnoge+/U09lcGwv4cAog
 KU41XuhlPyhiPFSV6b6VjwSMnAQodsT0OMobQA+qUp839Rw+q+vitGCZOFaEq++1NWjxMjgI9VS
 45apl0UuUsqCOKGqnUwmLJH2SV67YrVvytX/zpJ0gkpcDv0ZL4aQdQLDXqya9yciRrrLiSg=
X-Received: by 2002:a05:622a:251a:b0:535:a5fc:3b53 with SMTP id
 d75a77b69052e-535a5fc44a6mr205204991cf.63.1791919769805; 
 Tue, 13 Oct 2026 12:29:29 -0700 (PDT)
X-Received: by 2002:a05:622a:251a:b0:535:a5fc:3b53 with SMTP id
 d75a77b69052e-535a5fc44a6mr205204621cf.63.1791919769257; 
 Tue, 13 Oct 2026 12:29:29 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b79a186sm109301131cf.20.2026.10.13.12.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:29:28 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:29:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/4] Revert obsolete & broken workaround for GNUTLS
 thread safety bug
Message-ID: <as6Gl_UDqjmuASF6@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261013133622.993935-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013133622.993935-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 13, 2026 at 02:36:18PM +0100, Daniel P. Berrangé wrote:
> A year or so ago we introduced a workaround for a troubling GNUTLS
> thread safety problem that hits when a bidirectional TLS channel
> is used and "large" amounts of data are transferred triggering
> re-keying under TLS 1.3.
> 
> Unfortunately that workaround turned out to not work, and since it
> was close to final freeze we disabled it, rather than attempt last
> minute changes.
> 
> Fast forward a year, and GNUTLS has shipped a fix itself and RHEL
> at least has backported the fix to stable releases. A user who
> is still affected can workaround it by disabling TLS 1.3, or
> forcing use of a different cipher to avoid re-keying entirely.
> 
> Getting a viable workaround operating correctly in QEMU is going
> to be challenging and fragile long term, so not worth spending
> more time on.
> 
> Revert the broken workaround (which was already hardcoded to be
> disabled at build time).
> 
> Daniel P. Berrangé (4):
>   Revert "migration: activate TLS thread safety workaround"
>   Revert "io: add support for activating TLS thread safety workaround"
>   Revert "crypto: add tracing & warning about GNUTLS countermeasures"
>   Revert "crypto: implement workaround for GNUTLS thread safety
>     problems"

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


