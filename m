Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B5EC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuuGd-0005zx-36; Fri, 14 Aug 2026 11:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuuGW-0005yQ-OP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:56:17 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuuGU-0007uS-CM
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:56:16 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81f64e8dfbcso17188497b3.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786722973; cv=none;
 d=google.com; s=arc-20260327;
 b=ocnrOeiTjms6dhide+ZOmyNpreEcJb6Rw1jFKw4+CA2bp/hicQwE5sRL8qzeZvjIlH
 PUfPGXkc5qINQREWPMG8+2KB8JZCE044Ty35/jCgtL//zTNxtVcX1V99evTb/6f+/Sbp
 UBgy9lVBjvHgshAqsfse2e1T2kW6u+K78rSby9RWe+zRlg3j8CbonSj/pd52aXR5uj52
 lV+OQE8uVbmIn0w2AKrUkFvpweAfhGm2gX3++0aj5g2RXPPSaF/oZqzhxNJuHIkBwIAD
 lLt3KetHBJViigZHVf6Zg97XWoKr0S2AKwl7imIJd+VrPytnhsFWUVQlyn90sdSUINrQ
 mDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lg/Ruw0d+vajfGGcoV2/3L9GneOxOoZt7dCao/BHJHw=;
 fh=j/ZFQAt5UCA3hTI9apHsoEu3XL7I0XuRAzsPOH4rEwI=;
 b=WFnMWvAcG9XT4A6C97FLqHpXieCKZj0+pI1sh6iZW5SdN80g1tcXAAZX1KBI578Vy2
 F+MOY50xTUOpNfSMfdo4Py6VQ2mPa+sXuW8Ws+qBXAOMe1iY62bXfIah/tKEYjxbH9Tz
 V0Wdc5LKsUSMpeiQP+ESB1C5QnOi3mzUR0vjKe6NGbQCE0Vv/YUrADYIR+8ngjubdpkV
 2zHpvQUVgHUeZQaVxaglCv9+ZhxhgHJYJooXMidp6s+bgUMCWojieiPIfzmnB5Agxas8
 SmN3c5Bp+vJQI7sufY3Yw/tfuyPLZU6reMllycJfjZqGPEk/9nnBCM8yvrZtBqVgj67q
 9hoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786722973; x=1787327773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lg/Ruw0d+vajfGGcoV2/3L9GneOxOoZt7dCao/BHJHw=;
 b=IhSrr/rXVmjPmxqJXcRiiMAoZ5fOCHh6J/7NNz4BEAjm50v2LGpyvIFw/APlYvDEgf
 CK2e9WY1B8mo0uT8I4gFBYZm+mPtMiHbZ9tnJLcPiXCgdsq++LBOxnZbfyf57dwpA8rp
 ICONxcBvNC+eDIM5KTmyTz5sXgdxrAVQRIcOG5HxPaiIMeKafJ6cwTcHEO1o20MBj47o
 eWXd/tGzKhK30vxGh82YmT4CsoZthkk6iVKt2L6/h0CD4bVf3vZAaE1hnZTb6NvopMus
 zzQ2TWF1MX3mPMZpe3bpSky72GyAo82wrkS0S+ZCZ1jCownMdrADMBf/hBnYA5Bq/3Li
 rdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786722973; x=1787327773;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lg/Ruw0d+vajfGGcoV2/3L9GneOxOoZt7dCao/BHJHw=;
 b=A6wiwOm7DnUCyxLiIahwZpjAdj4bpEDw41ya6AZBgKvT+2Z/p780LIVZ61xh14vtJd
 WuLq64hAZfJb68RfO7Spna2UiyrLnmHoH/93wRhAfBYwt8PCvl/TglI4Y5y2ZMPQnNIG
 uYbFcbR97COlXwo2VOUS+Tvg7e4S8MD9gLBWFUtbs37Ap+quiyjyy9phbEnip0rqxPT8
 DOYTFyu0iNFN86nqH9oT20MfMnxNdDkGHfEGV2xvgm04UrFxB9YG1ZvqHKLoDCEl9Uk/
 f/Ec0a/hEqwnYNWXyTF88gOuXxBjshIN784HL2iYAErrrwpQ324tnsqcZaW5DHTbuzae
 ZmuQ==
X-Gm-Message-State: AOJu0Yw+YHbINYGNVvvUOcfzNYsvNnv6Y1oIlQAIJsv0gRM7Jp7w96Zm
 QCFtv9OgZoql7iZ82d6trzl6P6OTmhREtJwOS1ZF1KebNJVcygjE9Z5BuBQZUxswqfOLj6weizB
 MWw9cBvKOExLok82dfQEi8vAye5QOAlg=
X-Gm-Gg: AR+sD107XX5U5hvnaDaU86e3vPLWUk7rrrBISI1f9nS37/OVnnJCl1BW7lBTNU4R0wr
 FoCknO1hXW+CoVh/ZSn6s/fPKmbIeU3QVDF+GW5SZbACDDdibQizc2BT+yy4PjPhtB75tvuX6bF
 VusD77sKa3l7Qg7KDYkJzqpeLfZwI+RmR975+Pu4Vt3wIszOl8HqponWqMGMeCDm+yhOOP3i5Fj
 9Crw4DeiuKWNdWfAtVby61Ecd84H7CtKrNPKpDUtMUwBLHTNeaQ1Zv/2aAwJnz1r1iTRjRtB31G
 NJrksmIJub18nzp6P7kSWtbj+HNSXSyJEBQgcGknCs4=
X-Received: by 2002:a05:690c:6d0c:b0:833:4ca4:f3d7 with SMTP id
 00721157ae682-83712ac3230mr30350617b3.29.1786722972878; Fri, 14 Aug 2026
 08:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
 <20260813135717.2758-2-flamboyant.h.01@gmail.com>
 <CAAW0U4ZRqfcNmWi8davsvu-zVFmq4fJgbjjESb+_As3vPnu7jQ@mail.gmail.com>
 <8004347514ec6b8f002d9f47189e97e17f42429f.camel@alistair23.me>
In-Reply-To: <8004347514ec6b8f002d9f47189e97e17f42429f.camel@alistair23.me>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Fri, 14 Aug 2026 23:56:02 +0800
X-Gm-Features: AUfX_myZ85ngJjToDWUQY44UqWowNSyVMGhLE_vyQ__SCIym_1G36opZ7K_lmQI
Message-ID: <CAAW0U4agOaAedrTnPzswdpJToNED=gjcWV4KZ883shgn0HoT7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
To: Alistair <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>, Junze Cao <caojunze424@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Alistair <alistair@alistair23.me> =E4=BA=8E2026=E5=B9=B48=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=94 23:09=E5=86=99=E9=81=93=EF=BC=9A

>
> Please don't add Suggested-by tags just for review comments. Generally
> you would only add Suggested-by for new patches where the idea was
> largely contributed by someone
  Hi Alistair,

  I Understood, Thank you very much. I will not add Suggested-by tags
  based only on review comments.

  Best regards,
  Kangjie

