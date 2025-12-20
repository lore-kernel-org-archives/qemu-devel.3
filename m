Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6D5E668B4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 14:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWyJC-0005j0-Hf; Sat, 20 Dec 2025 09:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1vWyJA-0005iO-8r
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 09:51:48 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1vWyJ8-0004f2-QD
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 09:51:48 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4507605e19aso1741861b6e.2
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766242305; x=1766847105; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T5u18xbeTgr335iXaFkYWNpW8fyie7mGSXz+0RaVF6E=;
 b=aIo0sPN9yh/gn0m/Z+Tej2gMzPrTOnrpM2cO/oQI+wkkcbLVWzFLTZkHgaze3VflyU
 qTRFhCOZ12Qm9j0uXLQY4di/6w+pOuCQTRD8FW8wkg+aXAAj/S7gZX6YlSXr8Ct3KvOf
 2ECQumx1o5LMVDYy4CkcJW3PQQe0KCGlyTVT1J1uZdqpgHRp+V4P2WzGonJLjgdb86on
 I8rC7ZY50ye+8eoCym/GgypLLBRR1O7zq4D0iS7KKAEATq1U2A2wb8aiiPD1aTGubQSp
 D4h7OOwgyyUoZmcviKl+ulsV7vnH8Ys2cAUijQn6LTE+vQucVNqQim53jhNIjaadmU/K
 oskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766242305; x=1766847105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5u18xbeTgr335iXaFkYWNpW8fyie7mGSXz+0RaVF6E=;
 b=Ry9BtL0QuWCh1OHkhqhyNh3s3Xq9kmm9noY6vn1+PWW2c0527EG5+OweMcnCIOhY/o
 71W/vfmY2Tr4+JXDrproXFgV02hRrT/JFiayB/ythGTmTbzYVCBPLBsF4bufjEZi8nKM
 Hnf/njiZzEczI/N8Ak/b7xtVC1j7OXbzNwAd8v7uD6XKwWbP4ouqofyS+eTLbEIqB+aT
 w6BlXf9hT/ICBfCRNoZoJbbvdTsZSPhkBo3S5htuzADQpMBjYEp95AyrbMbs3LWL1JUx
 Hpc3a8fxXp9LlPjo0uHJelrn6ysLBsgPEA4g6cLidYWE1JsVjkeGS/MYLq1vAZF0rG7J
 QyRw==
X-Gm-Message-State: AOJu0YyQfhSZmKz5iUceYYGlK2veR0uCWfECL/2bHmp1DAgsgZq2y/B+
 Xe9xI0VLdTnOsH6Qux4QFmsnuTN36TTBoVZhG8DbVDyAuleOEXCGTdFpqRBpWm0JGHujC98bOiv
 5GsHCIl+gyayz84K5FJMo7sZChbQfvBA=
X-Gm-Gg: AY/fxX4fah7hSH4FS3ze1Cu82JDLzMzoCnISLcZbrnQRGcP1Si1PIz1SS3W3tYJx0CC
 JbfwWQ9zZw9KCmy7qq0/QFgv0aOOPYnliaCKRo8KSzFGPn2m34WQxqXUYg2+zTReAP4vG6CM1SM
 PvJi/W0/901zMmJg4nyXGLT+Sj3MZWnhFYDPd/GC7RW5BuRo2IeLpmlvEE8/9YSaE32fku6b4Ow
 uvSZRKaxKbd2mgM9rDa725mVqfG5k/chk3mYfVWsx+ccQMySALp+OdHVFFgXJ5Kv6LApU6sx/vw
 SOVrOciybg2tGqPQ2rpul/WnUgtV
X-Google-Smtp-Source: AGHT+IEtiH2+MGB2j5VKQP7tvnCfIkOySrqNHKk81Ein3natHTxbpyqfJ4OZvyiS+yaOgQd5hMp50bMex6qQ2+gBeks=
X-Received: by 2002:a05:6820:658c:b0:659:9a49:8f63 with SMTP id
 006d021491bc7-65d0ea9a76dmr1700863eaf.40.1766242305162; Sat, 20 Dec 2025
 06:51:45 -0800 (PST)
MIME-Version: 1.0
References: <87ike27ucd.fsf@pond.sub.org>
 <CAMyd1rQ6CLN2FPic=4pNpZtcw46io2xftkBDSLfd8V9S+Jyu0A@mail.gmail.com>
 <878qex3ac7.fsf@pond.sub.org>
In-Reply-To: <878qex3ac7.fsf@pond.sub.org>
From: Jackson Donaldson <jackson88044@gmail.com>
Date: Sat, 20 Dec 2025 09:51:34 -0500
X-Gm-Features: AQt7F2oObooRwahswLNDL-Yvu5u5nuy50z9KGrNHMUPYcJzWPRA_Nw7tVxvmHRQ
Message-ID: <CAMyd1rR9HLwn-fzWfgqu=ZdtOq_Ae6Den-0oCmZpXAjxbup87A@mail.gmail.com>
Subject: Re: MAX78000 machine needs a maintainer
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002fc08e06466355c6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=jackson88044@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002fc08e06466355c6
Content-Type: text/plain; charset="UTF-8"

>  Out of curiosity, what was your motivation to add the machine?

I wrote the implementation for my university team in the 2025 MITRE
embedded capture the flag challenge

--0000000000002fc08e06466355c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt;=C2=A0
Out of curiosity, what was your motivation to add the machine?</div><div di=
r=3D"ltr"><br></div><div>I wrote the implementation for my university team =
in the 2025 MITRE embedded capture the flag challenge</div><br><div class=
=3D"gmail_quote gmail_quote_container"><br></div></div>

--0000000000002fc08e06466355c6--

