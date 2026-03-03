Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF5EDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUj9-0003Ca-7C; Tue, 03 Mar 2026 13:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxUj7-0003CF-JL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:44:13 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxUj5-0006YC-Ll
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:44:13 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so5466395d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563450; cv=none;
 d=google.com; s=arc-20240605;
 b=jLEuMN39JdLYf5FDNyktodf/IN0UcP4ZOa9g5Muv/+D25L9yzGnwyc6sTd6ExKSlGN
 FG3Dvcj9BfEhqwzrKeb8gm/t8rD3Mchec9vy7ZDv9BUKA8wnJhCNqISRNJa6gbxO4xuZ
 xPze19Ouk+9OodVhm/N/fmxAFp2Gpray/cCFhVObGoLy1cdc4fYvcEh7ujDkAP6bwEZY
 YmV7npXtpMYxWX1G0c0XkyfXOttl3w5cJ06/srzg0n+fHb/YzBAIrQqZGWo7nC7yInE4
 Em9N4SmpTW088LG+cQd4hOuVdG7EeAsVmJh4pTtd6EqcSWXjPq9c6piKJPqA60oUzVmV
 qBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7yQFde6shSEuD6xHB0wkTMivUqLOg+eUFfbOLCED0oM=;
 fh=uHXOqP1cjsnXmDDkmPSxhpJ0KLoyAyFEdF9eps3KZjs=;
 b=Zm/YfhncBZ1DEnCYCCD+O4JuWXg5TdjgJV6+oHFlBZ95Q2NGXRdGQjiLvZRJMnwBwp
 0BaT9jh0IztIYPLvZgV9jKnJ9IFDJJ8aESiIS0Gk3Kz3pZs+RK3HkAgLyIYgxJFOitXS
 BkUpJq+5ozOOlAUKRmmSMELhocOSlrcZu/SyJ7BoJ6Fhp8jsps7Sy6bVFKqBDcU00plj
 L76qTkUJSzT3S7eM72+ye7OwN4hBKfeN884oQ8ZHeGPCkSffXdmYu74GxmvhTN7Rsjfz
 Kwuv17rXHBZCARiOV7Sm/DPyW9mH/TGHzAyw/RXCGD64Qas8PXECkRAlUzmDAmrujXBG
 iW/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772563450; x=1773168250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yQFde6shSEuD6xHB0wkTMivUqLOg+eUFfbOLCED0oM=;
 b=N14ougJ2wM3Iu/+zKYsw2mLq2yfW6033UdztK/8sRH7xJLjlTSrLoP0T/6MzC8g877
 rf6/ffw2WTmsD1qyrruQjL3/5cuTNH4kak43U9kVRa0rpa5JgnkxvefegX+RXBs8F8Oj
 +fAFdZ+Ht6/rBNAhcHD1PfNATTw2PReEFhrNNKHc1Uh1kK2I4VRkYFpzzPBqtb/X2UD+
 slKEoRIyxreUQApi/1FfZx3Z1I8/7cRq31657HvfdK3YdCJSnrwFaEvjqewgaPlGWief
 v1EUxp0COeL9hrKnsZOtCaWAvHqFH5fkS52C2vcNsB6ZorkBWBwxag8TWynKgec5GHFh
 K7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563450; x=1773168250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7yQFde6shSEuD6xHB0wkTMivUqLOg+eUFfbOLCED0oM=;
 b=M+EGFTlj9Saf8khs4JfELHyxlf1/RZVIpgAQR+m0lNc6Fx9qFxiR0yRTky1hh8H+q8
 mtg+2NdWhUts13kuCg/7ovTao0tnpx3ar3cjqREafhj7kN9dczFtwwz18b9crOjAgmDP
 V6L3MIMHxYmGnjqJSWJE0K585Kom5rE2IqM9QJnJ97iVfT0tD1b5Cgbdc3/MPKL+MPOQ
 givWXQsyvOt4rjeYvAMinBWDAMkL0PjSuB1NHoxi7dYFH16X+PbuWway/01sZTLJzV9h
 H9r6UsfYhTbjs5p8gix4YLffHUPZmOT4+r6FbJDTUX3oAOOgnqhjAUYmJ3INbxKMmln+
 UFvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaULMvMwGKVvGbdcUrYM9z99zYKBmh2KwyoTrre0dfiCO9hlozbhi5jqlB79OIRaJnSEdzxvNXvfH7@nongnu.org
X-Gm-Message-State: AOJu0Yyz9DqOA4cCk/nHN78rK3gcg8fOvexcWREAsUf1E33w8Q3VwGH1
 1VNXf0lVBpvEDoVmNQO66MiXUDYdflul/0ev91SBXVUTSiKiMKYKqH+3DPsJH9yU8RQ9B9y+q5l
 jO3Onwei94NbWYqtZ3Y20yRDL21F/KqU15r7x3zgC4GPE+k+58EU8zXM=
X-Gm-Gg: ATEYQzzGz+z/oW9VJfIJBMAP+7Ev757BlpyO2z/LFjFOjOit/5xuFgv5Z+UDoKJrnHb
 0CtJ9clV7EQiEe9yAOzipA/MwWpZyONZScSAObamS3CdMhHVW7doeaK2/ojCCT1JcqGDOtssgw7
 xBmLb6PwP1MLJFt4NabpCyUiH4aewymRsNX+m46BsqwGrayUrQ6mqJYyxdkSB8q1ILD9/1WqJS/
 UlVwMJrdq7dNqXyq45Dtba08EP/mQhbahDORhGjF1YHEuFmk/2kDHPic3viw8NoJfalcZ6gB8up
 kMo0kn25yROp85IRetU7DQK96oCTpAZttCuDeNEAOUAQ2YyYwtv6wFUZi24nnVGZtTs=
X-Received: by 2002:a53:de46:0:b0:64a:e7e0:a717 with SMTP id
 956f58d0204a3-64cc2193e32mr12863824d50.37.1772563449997; Tue, 03 Mar 2026
 10:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
 <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
In-Reply-To: <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 18:43:58 +0000
X-Gm-Features: AaiRm52REslOrhSITVVcQNhoEBm3OTMsDQQ6NBVXPx9_BfEaeYtFF3-8OrutBRM
Message-ID: <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 3 Mar 2026 at 18:32, Edgar E. Iglesias <edgar.iglesias@gmail.com> w=
rote:
>
>
>
> On Tue, Mar 3, 2026 at 2:33=E2=80=AFAM Kuan-Jui Chiu <kchiu@axiado.com> w=
rote:
>>
>> Hi
>>
>> I was referring this commit of upstream kernel which xilinx added BXRS
>> register in Cadence UART driver
>> serial: xuartps: Adds RXBS register support for zynqmp =C2=B7
>> torvalds/linux@3816b2f
>> <https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db20=
3ab905a889>
>>
>> Peter Maydell =E6=96=BC 2026/2/16 =E4=B8=8B=E5=8D=88 06:53 =E5=AF=AB=E9=
=81=93:

>> > Where is this register documented? The cadence_uart.c file
>> > references the Zynq 7000 Soc TRM UG585; its URL for that
>> > is out of date, but looking at the copy on the AMD website,
>> > there is a table giving the register summary for the UART:
>> > https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-U=
ART
>> > and it lists only registers from offsets 0 to 0x44.

> There's documentation here for zynqmp:
> https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_byt=
e_status-UART-Register
>
> I haven't looked to carefully, it may be a register that didn't exist in =
the version of the UART on zynq and was added in the version of the uart in=
 the zynqmp.

Thanks. On the subject of Xilinx specs, do you have an opinion on
https://gitlab.com/qemu-project/qemu/-/issues/3297 ?
Our Xilinx AXI ethernet device model lets software write to
the PHY registers for the PHY ID, and it's not clear to me
whether these registers are supposed to be read-only or not.

thanks
-- PMM

