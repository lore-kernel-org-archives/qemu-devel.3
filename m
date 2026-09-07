Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B5AC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZUa-0005OM-C5; Mon, 07 Sep 2026 09:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3ZUZ-0005Nj-7O
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3ZUV-0000Tz-MV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788788070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IH7k3Sp/S69rjWqy9WRPlRNNm2UeecG8w7o55h3w0vg=;
 b=GM9atlk+pi+8rHrCKt21UjPyduVd2gzaCcxptFg56Imx0GrUB4yQHjlpLbF14aA6V6uDnW
 hZSVEsGscWPZn+J9ta98PjD0BzAaTI1gqywpO0zn+wVhmiwCEtEjwL7y92Hr1+8fFKKrjh
 igAI9APMBmmLzjyt1/qvHNc21DRLH/c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Ncmh1IrAP6a212521x-ATw-1; Mon, 07 Sep 2026 09:34:28 -0400
X-MC-Unique: Ncmh1IrAP6a212521x-ATw-1
X-Mimecast-MFC-AGG-ID: Ncmh1IrAP6a212521x-ATw_1788788067
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so2521240f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788788067; x=1789392867; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IH7k3Sp/S69rjWqy9WRPlRNNm2UeecG8w7o55h3w0vg=;
 b=ZapSbLdASMglEMm4wUN+qZ9XEkEL/jgUHJIfyKpAo53YdNpA3j9aa26Cua7xsl18xX
 90mU/uL8yN1A7qC/Sb4zbb2hzKBGq1haw3bzGVbrIYE1o5yQLZxZV1eUOX2Z9ojM8/ev
 cmXTIz+JmVgCpgG36MtYal5ZQ6t2Xbb9U0BUY/ZrPgvFA1gExvTIAzfrzievbuiDnR1y
 VRWW3SnCVt01GYz63tcJBvcB1tUPhdTAQsi2cCWva50BLaPmqgKCtSzRXGmJA0nm69Jn
 JMIKG1UfWf2dPUg7xkkMXbQ/MoEcAxeyEsV/2buq5B/Hm2e5T+unebSoRUekOdq7w8Jq
 VAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788067; x=1789392867;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IH7k3Sp/S69rjWqy9WRPlRNNm2UeecG8w7o55h3w0vg=;
 b=dcpIsW295X3RQsnd+hQTow6Cyq0ONVs0H5b0/WPKneSaJUUMufhCzq5dnBa139zwco
 olHTJA4QotnuXCn36GYIJamwTmpny1s56xj0Z+pe6z0gUCGZ/meT0m1aiZuKFzzFNVwu
 bnzosxrHDChsv9YikRyOboihICUvcgY1xSmXOv7M282LrKGOlfJglNllZKWBC5Z4MhKk
 3X10X+zbEnW0okiNzNFRAMKRPOolheerViVm28/IGtOMntVJaB9+y9FZASlkIqKj9pcP
 TdxgvZLMvnu7/JjtSj5pENqyXuG+kVUC9fIWE6IzpUzoj2iNiMER3ozaP0I1GX1RUiLE
 g/Fg==
X-Gm-Message-State: AFuF++nVW0EH8w5eJhhTmWm8f9Tl+IWHP6IJl3TDxPCPX2lmjtkL5vjs
 tY8+87ovYNHruZx0zSiCE0uLWQ37f/vGJH+pCY5CMqiOcW5XCAwz7W4s8SlhtWgJdQjoAeCgHht
 7e1njzxaS6tZp7xVczsOLBHyXAdVeNKEdX5BsFhpXc2y5laU7sDpE/gRY
X-Gm-Gg: AYBFou1r4viqUnEZ2K9iilrdDmjBIZAqxnvcrYf7+GlNbC9aO2/rfU3E/jY1/FhmPn9
 fqhx2KNCKLzznOnFR64SCo1fwUeJdwLjAwMv97Xn1dFHOh6dlQTF9oXlCjEDj0LAw7YMZLY5A9X
 KR3AvlYqfbgdFzi/V+IEAKinuZpmAxZB7Sl+i363OjWXnuVKhufC+XlNvLk1WaQKb23qxPvaocq
 EqIoaWd4bIwOILCx7GvH2++Ydlv3cjH205hIIzwyW+TFEzuWHjkrtNxqdQHocc4mf40ea26R9sW
 FO1xtCrmgC/bZ2gLnvbMF8H+MT1GBrKWyScso2JFC/OXO/JgXLx8qvnP+/ZpX9Xtb0uDZH3Cmg0
 SjxM4X4ZexHnc4gm97lx+L3E=
X-Received: by 2002:a05:600c:c4a7:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cf823d0dcmr244675955e9.8.1788788067426; 
 Mon, 07 Sep 2026 06:34:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cf823d0dcmr244675215e9.8.1788788066949; 
 Mon, 07 Sep 2026 06:34:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm457559185e9.13.2026.09.07.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:34:26 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:34:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
Message-ID: <20260907093319-mutt-send-email-mst@kernel.org>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
 <20260907075640-mutt-send-email-mst@kernel.org>
 <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 07, 2026 at 05:22:43PM +0400, Marc-André Lureau wrote:
> > maybe just avoid stdbuf completely.
> > i don't remember why we use it, but it looks like merely to
> > disable buffering for stdout?
> >
> > If so:
> >
> > setvbuf(stdout, NULL, _IONBF, 0);
> >
> > will do just that with no asan issues.
> >
> 
> That requires modifying vhost-user-bridge, not sure that's what we want.
> 
> thanks

why not? it's not like it's a facility useful outside of testing qemu.
If we were we'd probably disable stdout printout completely.

-- 
MST


