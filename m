Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0DECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUmq-0003DK-5g; Tue, 29 Sep 2026 06:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xBUmo-0003D9-NI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xBUmh-0000h7-3K
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790676601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1v8mf15LWPsV2Up7vS5+5ElWryLHVs2XPJqUhfCAVUk=;
 b=JbtdTNyD+4/1dEahqU+f9CGo6I5nO2RdX6ndnPwh7UgQQDvMWMf4+p7SINQkNQyTYN0vZu
 U4hGu1/XkrutxNSWSko5611I3cMTLItvmmBzo/4jP310Es4OiHCCO8Pmcr4aNlqjm2NllB
 p274DR+qq0nhLoi6iQM8uIhXKl8GQ7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-2iSGXf6PNkKQ3BRINIeuxA-1; Tue, 29 Sep 2026 06:09:59 -0400
X-MC-Unique: 2iSGXf6PNkKQ3BRINIeuxA-1
X-Mimecast-MFC-AGG-ID: 2iSGXf6PNkKQ3BRINIeuxA_1790676598
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4843227cfcfso552152f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790676598; x=1791281398; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1v8mf15LWPsV2Up7vS5+5ElWryLHVs2XPJqUhfCAVUk=;
 b=jCn7B+YzXU91gb4DRowmD6ppjKiU2dDp6zsOSWtmLaVJytL5lcDSLpjsF5ZVZIM0n2
 xnJMUxXrw+rlgPc81RRo3bwDqULA6QC9d13e4FWVJuiWTI4XQmkeXi9X8Cy2FRSrnKEr
 YXflrCG4U0p5k85ykp3FsFWNEsvaNQthLNuRNueB65hgJ4FXOPi/I3b0iasDOAXPaJUA
 ryCZKSarkcMluOQDemiQQ7p2UBnr5OJFRqErowtUDA2+7BN6fz2jVKU3teWijWeOpYLK
 YKqQfVGXenbjaz6NQJnctAtkUP3w+crVFaJjEf+J5iedPIldo6LjhyQeX51yGPsTcKDU
 k1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676598; x=1791281398;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1v8mf15LWPsV2Up7vS5+5ElWryLHVs2XPJqUhfCAVUk=;
 b=qWStWN3WYWn8NCqrXGdZ36kxmPNYoTZuQ6ln278dnHiD3dUmqLcahTtthz3Q+zM/KO
 2LnApw6a9it75/NLtjdA7XnmjRgl/yade6n8w4Fwb0y3mljvsJJHAt8wpHNhej6xxw+H
 BcDqbrAs0N0Le+TJDFAEeYEKV1t3qRKA5u+a9n9MLeoFqDMGY7tIldHq+xY6s38z9/JS
 cLwmeeQcsdhabe+sojBdtOSETTdQqpDw842wX8ZUYf+JQV4PY4RxgnD92ujVczjHOqTp
 IDEFsM7cTn4orfHg82gA0ohYJcAgJp84X/XtcZn2CFx45Q54Q8y9D6mI50Hw5KC57Tzk
 BG5A==
X-Gm-Message-State: AFq9FYKLAmOuMoLZgL1Azt2+LSXoRAfwb7tudhgUYSmhbKu0FK0TQ0jn
 js8u+13EIIUUjP6ijYI1B8iVnSADeoqvF3wLLc1QHnLkdXIYEqjIHQ+NrWjjFUAHpfrubV9NTgu
 sHybG6hzH5wTmsegLF4da9KeV+f1vfFH8jtGF6qeoJwnLid2oaPhfItEH
X-Gm-Gg: AYBFou05r7T4O/GJ72m59VgSR8CRY97s0sQYWt0pF3AMwQVnYJo6oK9/aWtS1Z2bEVh
 hGNMgWYmSFZVrjPKgAJ9XDxg63NMOMHALtmaaLyjxR2MQuHhpQ3Pc4p92uyQz5P/hY6bPC7C6mG
 1TKKVF+u4iRPxDkh8gll4JZNdoii/3MeXmTomYnbSa4T6JIEouCdGKrRU8YrtNOJatrCOA1vIR/
 4DBQ+5xiw2cjotFFzqokty7KpDlSc0jGs5FRTrlA7WYzqbmAYBnnC9h5DxqeRpccs7Ug/oRHCDV
 u/61fFc4eluqjUOkvtHNahPlH9wAGQedUoBDHPz4lVQGNoi+Lr9vTS6t/V5b7kj2XztW81A3++L
 GzmJIN/Jp3cWzvW0tvH2mIlwwV4aCxfsL7Jo=
X-Received: by 2002:a5d:5f42:0:b0:488:8a8d:7d15 with SMTP id
 ffacd0b85a97d-48af1bcf4bemr3938785f8f.28.1790676598153; 
 Tue, 29 Sep 2026 03:09:58 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:488:8a8d:7d15 with SMTP id
 ffacd0b85a97d-48af1bcf4bemr3938384f8f.28.1790676594431; 
 Tue, 29 Sep 2026 03:09:54 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f886b6sm3197785f8f.1.2026.09.29.03.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:09:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:09:51 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <tcalifan@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/usb: Fix USB MTP heap OOB read via dlen underflow
Message-ID: <art37iLkXpyFTChW@leonardi-redhat>
References: <20260925092314.50106-1-tcalifan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925092314.50106-1-tcalifan@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Ciao Tommaso,

On Fri, Sep 25, 2026 at 11:23:14AM +0200, Tommaso Califano wrote:
>In QEMU’s USB MTP device, usb_mtp_write_metadata() computes
>filename_chars = dlen - offsetof(ObjectInfo, filename) where
>offsetof(ObjectInfo,filename) = 53. The dlen parameter is the size of the
>last USB packet, not the total ObjectInfo size. If the final packet has
>fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
>utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
>process memory.
>
>Add a guard to return RES_INVALID_OBJECTINFO, preventing the case.
>
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
>Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
>---
> hw/usb/dev-mtp.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>index 1d8cfd32dc..704e6c533d 100644
>--- a/hw/usb/dev-mtp.c
>+++ b/hw/usb/dev-mtp.c
>@@ -1704,7 +1704,15 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>     MTPObject *o;
>     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
>     uint32_t next_handle = s->next_handle;
>-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
>+    size_t filename_chars;
>+
>+    if (dlen < offsetof(ObjectInfo, filename)) {
>+         usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
>+                            0, 0, 0, 0);
>+         return;
>+    }
>+
>+    filename_chars = dlen - offsetof(ObjectInfo, filename);
>
>     /*
>      * filename is utf-16. We're intentionally doing
>--
>2.55.0
>
>

Thanks for this patch!

I ran checkpatch `./scripts/checkpatch.pl HEAD~1..HEAD` and there is a
style error:

`
ERROR: suspect code indent for conditional statements (4, 9)
#34: FILE: hw/usb/dev-mtp.c:1709:
+    if (dlen < offsetof(ObjectInfo, filename)) {
+         usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
`

Please fix it :)

Also, do we need a Fixes tag?

I think:
Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")

Probably we should also CC QEMU stable.

That said: I'm definitely not a USB expert by any means but I _think_
that we should not use `dlen`, but `d->length`.

Correct me if I'm wrong, but IIUC a transfer can be split across
multiple descriptors, each sized `dlen`. Using `dlen` there, means that we are
checking against the last one. It could happen that dlen is smaller than
d->length, triggering the check.

Does this make sense to you?

Thanks,
Luigi


