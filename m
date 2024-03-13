Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD0BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMIn-0000La-Hv; Wed, 13 Mar 2024 06:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rkMIY-0008UJ-7R
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:57:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rkMIW-0007QN-P5
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:57:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so1153926a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710327442; x=1710932242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdamQsR+I1vMaAaWNE66CDZfYY+db7ooByipPqU1hzM=;
 b=C61/m24+luaTPNNHCejHE7YpVmSc4ktFWbW3ZodtDHrRyq+3RSRCGPH8TDTpdjhRgT
 CUkuvfnN5bFw0Jpa1fzBybPAXDSTvHCotUaBx8zwVnRNAgx5b+3s7quyMPyWaD9TNWHu
 d/qjrxT4ohXmXouThTczam2ykPeua69wnoAnxf1aQzavqAqFECeKcpMH2Tqty7qT9/x3
 rA4nPvRgNp2P0YofN4bJDnzTNZPYYCFM659iBgbyVhzJn1GKTyfCIEX+9VSVXCAGqUlG
 MkgDJuH60DPDvSvg+1DZnWqg3ct9r+863dJIFDGdWq2HEQz/CiP5gsqp+UQPWlX3twjI
 edbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327442; x=1710932242;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdamQsR+I1vMaAaWNE66CDZfYY+db7ooByipPqU1hzM=;
 b=UL7laY0aEi1IjOXa5EUmT15tUoCWiWaEm1eo+FZofpTOBP1lYcr8HGOJeu2dD6bAGN
 VOUaSKITCVbk9NYJXUES+aU6cJwbvbtwhsIuf4vTnfLfuQ0Mt+RMuC6kYwXrKn4OZ1ty
 tqvHu8oUeQdQcOCuH2L0wJ42U3C/F2hCFbVVGbU3sywLRs3TC1TF8SrVCZibWoPizuvo
 w1oNDY9/rpnwvscaEnhK3lhS2+Rnze86UKTjiF7zMwBD0RO8adb/imp0GE+Zr4WwfaaP
 vtP9nUKTkp5WLV2QNFt40vpnJ3c13Z1SRA0AkOex2VTCohIfOP282emvStk8QD5JfaQj
 yTeQ==
X-Gm-Message-State: AOJu0YxUh7MUJaNrgsCBGl1N2j7CaXn+PyQDtv31u0yjTv16TdbH9TJ/
 JFAl3O6H7nRv3AlPC2AoYCEAgkp74lWOuOyDJqCpFHMNQd/w8smJNx3Y84IA
X-Google-Smtp-Source: AGHT+IFPQDbACJKOhEZRDu0r9LioD9fPdfq2+YbMgd+t1ogmWyE/5rg1o67moNUxqK+dBSgGsy8qlg==
X-Received: by 2002:a50:bae4:0:b0:564:dd13:56e9 with SMTP id
 x91-20020a50bae4000000b00564dd1356e9mr2308696ede.29.1710327442107; 
 Wed, 13 Mar 2024 03:57:22 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 t21-20020a056402021500b0056851310a04sm3598542edv.16.2024.03.13.03.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:57:21 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:09:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH 0/5] Implement port 92 in south bridges
In-Reply-To: <20240312114548-mutt-send-email-mst@kernel.org>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240312114548-mutt-send-email-mst@kernel.org>
Message-ID: <035AE543-BF9E-490C-A4D9-AAC8B07C83DD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 12=2E M=C3=A4rz 2024 15:47:21 UTC schrieb "Michael S=2E Tsirkin" <mst@r=
edhat=2Ecom>:
>On Sun, Feb 18, 2024 at 02:16:56PM +0100, Bernhard Beschow wrote:
>> This series attempts to make QEMU's south bridge families PIIX, ICH9, a=
nd VIA
>> 82xx more self-contained by integrating IO port 92 like the originals d=
o=2E
>
>Bernhard my understanding is that you agreed with Mark this
>needs more work=2E Dropping for now=2E

Yeah, no 9=2E0 material=2E

Best regards,
Bernhard

