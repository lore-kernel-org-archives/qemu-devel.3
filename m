Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB947CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDjcr-0002RW-Gn; Mon, 05 Oct 2026 10:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1xDjcp-0002Qt-Iw
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1xDjco-000295-2o
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791210303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SzvurHUhSyel2wObhQbfAtzIkIBaLQwaHpMk77SLTM=;
 b=htUDmK9TuLWH6AswTiTycnWoNb2+hslZRihzReTHGX6RBDiJyPvVpXwY1/NGvjd0YIgVIw
 nmsw6O2QIo4MDyIy/aGk7C0F9q9vTPF9HNzz/zc2aCTy5WLerD0kfxDV5mbnsy5y9Q73sU
 mlp4l7gfwIgV8rR1mOTTUm5ym25KnWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-XiC51QMUPgK5uZqEUSXYhw-1; Mon, 05 Oct 2026 10:25:02 -0400
X-MC-Unique: XiC51QMUPgK5uZqEUSXYhw-1
X-Mimecast-MFC-AGG-ID: XiC51QMUPgK5uZqEUSXYhw_1791210301
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so1113928f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791210301; x=1791815101; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8SzvurHUhSyel2wObhQbfAtzIkIBaLQwaHpMk77SLTM=;
 b=sWo48+zSp1VCjztCHrRzrQHD9eHHLFzSqbEwh+1oXwcLDS0FySQyjEHJP33XjplG+Q
 0vkOcP5+Rw7Fie83Re/RMvu4er8zGc0J/f7pyQPMRT9FkQA+8cFWetAsb3pUfL/U3WDV
 3M9YGdksnnTpd2L6PjqRz2crokeXpcjuITRsG3LFKBFivcFGA2Z0Mr2cy8o08p9EMsSW
 /UPUMb/cObk7Jwb/U3vo5n4CDkZmcAXR1yAu3WYJkMYDuAYdGMJ5eoecbeXx4pk5Uidd
 CURm4vfHlieZeAdnP7gKx8axwxXw85YBl4iu8Qa6kZCyTMHZMuXqPT2KfSzIKkjYgzPR
 SDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791210301; x=1791815101;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8SzvurHUhSyel2wObhQbfAtzIkIBaLQwaHpMk77SLTM=;
 b=tPZwQlOumCLt+P7jLzlk+7qwvazBv+XLzNvW+aXL3zLeoUy0C0qdkzWNhRD/L3wD0F
 +CzEZloPSKpqoTNpi/q04RKsZ51Q0lw/RVhLxvITiuS6+0EsZxGb6ejGnw/dfEcTdEYr
 nppZsqTfqMSFQEDjeeyaO8DKgQsEhvIk+L2vp1tzMz7Fy8JyEx12SSo027XtOCWOPbKw
 XDsSTfvFSl8VFLEje515/E+MlwCK6Ym/f31uHLSqJkNowjNkY3yIDmCRz0YgDYQYvaCd
 1pYGuAQoNrBWCpqaSausg+4CzzZUB2AfnKsDFZI95kp0rutcd0HkoWPzDt+uXDZEADtR
 rjdw==
X-Gm-Message-State: AFq9FYKFGSSsRY5f15zScUwRhfYIFMNICxMYS36rpweisr6uIZrdzJ0J
 ZOyKVQ3tGws8ViOV4iI3pRfiK24hJq7Li6v997ClUycqVzaBKoZuB0KElHwsM/3kQbWmsGVGFGB
 izS/BxvJA7jGTdHrxUfM0rx1UpynqwQ3FKmpZFqqFtpycpgoGIDVd7k15
X-Gm-Gg: AYBFou1f8YFnmEJwRaoFKFNW4CJpVqQLhLTmsg24wWMtvD8/8v9HNOS+FRDB/f+gWJr
 2bqnAl0J+p+U9/7m4sLUVpE6WJscXBZ8Bb1kNtZh3X3dCEDhfqzbCBrUJ3P9yTTd8iLogvvawmV
 zNKgizdWGbxaxXmLN5XMxf+81HjjY/m5jBSPC8PunpgBuQHKkRcgtU+rz5GNmMlyGAPkca7bk0Q
 8r50xbcr9U86vmhviHIARRi0eeB9jcNqUuRrB0iz62voot22IMUqpej64lkIJGkJEcxwz6aFOIJ
 2vdQ4JkBdyu03lh3fFsCs7lsXT/hIyxfPDbafs484xLakUxipZpPdPp3ljRj403X3Eh0yfc=
X-Received: by 2002:a05:6000:4707:b0:488:844f:6034 with SMTP id
 ffacd0b85a97d-48b1275c854mr18426777f8f.48.1791210301277; 
 Mon, 05 Oct 2026 07:25:01 -0700 (PDT)
X-Received: by 2002:a05:6000:4707:b0:488:844f:6034 with SMTP id
 ffacd0b85a97d-48b1275c854mr18426731f8f.48.1791210300715; 
 Mon, 05 Oct 2026 07:25:00 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229e0f5sm4666945f8f.30.2026.10.05.07.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 07:25:00 -0700 (PDT)
Date: Mon, 5 Oct 2026 16:24:58 +0200
From: Tommaso Califano <tcalifan@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/usb: Fix USB MTP heap OOB read via dlen underflow
Message-ID: <asOsJIcKYKaA-vn9@tcalifan-p1g8.csb>
References: <20260925092314.50106-1-tcalifan@redhat.com>
 <art37iLkXpyFTChW@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <art37iLkXpyFTChW@leonardi-redhat>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ciao Luigi,

>
>Thanks for this patch!
>

Thank you for the review!

>I ran checkpatch `./scripts/checkpatch.pl HEAD~1..HEAD` and there is a
>style error:
>
>`
>ERROR: suspect code indent for conditional statements (4, 9)
>#34: FILE: hw/usb/dev-mtp.c:1709:
>+    if (dlen < offsetof(ObjectInfo, filename)) {
>+         usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
>`
>
>Please fix it :)
>

Ops, I am sorry. Solved :)

>Also, do we need a Fixes tag?
>
>I think:
>Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
>

Probably yes, but I was not aware of its existence. Thanks for pointing
me out.

>Probably we should also CC QEMU stable.
>

I'll cc it in V2.

>That said: I'm definitely not a USB expert by any means but I _think_
>that we should not use `dlen`, but `d->length`.
>
>Correct me if I'm wrong, but IIUC a transfer can be split across
>multiple descriptors, each sized `dlen`. Using `dlen` there, means that we are
>checking against the last one. It could happen that dlen is smaller than
>d->length, triggering the check.
>
>Does this make sense to you?
>

Yes, you are right. After studying better the code I think the best
solution is to remove dlen and use d->length for computing filename_chars.

Many thanks,
Tommaso


