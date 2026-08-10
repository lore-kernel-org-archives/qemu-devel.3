Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D5C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRdg-0003v0-Kn; Mon, 10 Aug 2026 11:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRdf-0003ui-18
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRdd-0001Pu-Hm
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786374604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCHbKKzr5OxROXasiTpgSEv6U7Z1fDggYXpw+GfitUM=;
 b=YZkwNDR5W4/Nns3d/IrxPIucb41d/InT3eM1s7fwhquYQsqbm50lbUIksc8v2zgnY5ui/0
 g/BcS597TeDMJ4XePRPBAxoynMpmYbsKF9a2eCMyeuEbDhTYcirI/3Zxv/74ubnnofD7fy
 H3uEQ+EpoxedBr24kUGaaJbfDrlFB58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-G2HqWYxTNtmHllGTaJKj_Q-1; Mon, 10 Aug 2026 11:10:03 -0400
X-MC-Unique: G2HqWYxTNtmHllGTaJKj_Q-1
X-Mimecast-MFC-AGG-ID: G2HqWYxTNtmHllGTaJKj_Q_1786374602
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-480010f8bdfso616272f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786374602; x=1786979402; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uCHbKKzr5OxROXasiTpgSEv6U7Z1fDggYXpw+GfitUM=;
 b=Zz+3pR3ch61sFolusnGWcCXRTUYfO5yGBX/2uugc4cPw+4XqlHuLu+hhxAAzRXTAg4
 qrS4sDl227iCI0KCbYGmqndeUXeumaHPtefi8dauhiXlK2A7WyDy2+y0MFtmxODy2ENp
 Z0+puHB1vvqgSBMF+Ho1GaJsbYJv81aydGtptvfJZdaatqquwl4MRTv33XLLwqy+b/bQ
 IIEwQv6xioUMLK0Kuwg3mNmWwoLX5KR1SQL0cJ4HGzUEppuEmDwNIMNs9Z8/21KoFBfE
 ddqzBTcXkyTOj5XXSEHFFpRC6h/rqddEjxZanQGHEDrG6NOpmX18/zEf6p0olYmKY7P/
 LcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374602; x=1786979402;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uCHbKKzr5OxROXasiTpgSEv6U7Z1fDggYXpw+GfitUM=;
 b=FYUXP09lcBGEKwdoQffuoJntIY28wl9kq6kQ2FqHBrHqLH+HgK6ylKk2l8ILLzTR2T
 zE8QMhVIdMhzIuDj/o53oQy8D9zyplrymcSQC8nq5D7EBTXcis9XmGzr4kSY/1KImimX
 uC08/r/qusslIg0WpmYS7zzL/zTS8IzpE6HOo8y+d2MKCU0PWNkpl8Pi3PpJ+GfLxEii
 JG3Qm1V0YXBdbsO/Hy8RPAiNaD8ETlv67HY+XQs7sdWAvKzzjvhOlV205sNalfHnPSRQ
 qQbupl7+NZ0bnKxrlCZIEAfYRNt5cS3w6C5Wt8/EDXF9WlCZgJSPzqnY/YBl4CIBwtr4
 Wzdw==
X-Gm-Message-State: AOJu0YwNx5OUscevnSqfxy+Apw8WgaTiBtOkKY7/WEVV5KxKIk8g0JV7
 lyhUcEPPr9FL0hePaVDrOqSpj9vrZfH1OGx4fPjWNAVAdu2AFBDimPvxR4AQTKQckDkFyCTU19h
 Wpms/Ofkfl58K+rlid9GQN6iyUxh1ejvJ6rNhDoT3C5oTWkXmtjbgASmZ
X-Gm-Gg: AR+sD11/IDhrKyfjPXlDFVBvigBaVdgqFs/ECVTTWcHkNRcKPrNQct/qZ44lgzmFiqA
 BKESFV+Jh+UMnOlD2H4xM0xi59vH6vom6Mpkn5JHtPLgUVrsB05HKR+vTcl8+7dgeh6tx1Uilf1
 nAjyiZ/aL2Q9iRFvCqLJ8dz2hVLPR5IRxkL1JqAUli6TeacW5XSzzrcR6VTN2utNaVRLfG9uVHg
 OLaI9atQx3W3xU8/fuyCfla4zD38on7xmjPNZGbWrTHF27zkU8G6cC1ynzt+BhiaKzmfv6c089d
 lKKywLVlR1qAcLb0xUiOlKCWhihheKtsX9cdT5FYl2e90PnZyJtgPQzI
X-Received: by 2002:a05:6000:24c8:b0:47f:f4b9:88b7 with SMTP id
 ffacd0b85a97d-48002671fc7mr27781438f8f.1.1786374602367; 
 Mon, 10 Aug 2026 08:10:02 -0700 (PDT)
X-Received: by 2002:a05:6000:24c8:b0:47f:f4b9:88b7 with SMTP id
 ffacd0b85a97d-48002671fc7mr27781377f8f.1.1786374601987; 
 Mon, 10 Aug 2026 08:10:01 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220ab04sm32764444f8f.37.2026.08.10.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:10:01 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:09:59 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 04/11] migration: Use file_bmap for RAMBlock during
 incoming file load
Message-ID: <annpt2JfVZWdgQkz@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-5-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-5-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Replace the temporary bitmap with the existing file_bmap attribute of
> the RAMBlock. This acts as a preparatory change for the upcoming fast
> snapshot load feature.
> 
> Reusing this bitmap allows the destination to track page types during
> a postcopy load, enabling faster, direct placement of zero pages.
> 
> Since file_bmap is currently only utilized during the migration save
> phase, it can be safely repurposed during the load phase without
> introducing conflicts.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


