Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B76E83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDjw-0006bt-KS; Tue, 17 Feb 2026 00:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsDju-0006bk-Qh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsDjs-0007Mj-Kj
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771306509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G94O0XqLnIC+MeHyP2qJ5U/I9R13MKboSk6ZeF+uKKQ=;
 b=QOHNzRxOH6Bdot+/Zt0XJ3hEy1H/QeusVQEJGtrRs4yuy1y1ZR3hyRcQz2INojng57MADB
 z1mExLFkEay4Ai1USVVn3f6HRE5m1fy3S+YoNpSHd4N3DfkCZQceUdJQl9fNk7jzZwzIsb
 46APNgZuENM3ROkC30HGyUfiDmCl0D4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-uFk7Ufx7NkSZdWthi8YpLg-1; Tue, 17 Feb 2026 00:35:08 -0500
X-MC-Unique: uFk7Ufx7NkSZdWthi8YpLg-1
X-Mimecast-MFC-AGG-ID: uFk7Ufx7NkSZdWthi8YpLg_1771306507
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-894727de401so345845316d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 21:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771306507; cv=none;
 d=google.com; s=arc-20240605;
 b=U76MmWKcBD/+rB371Fr6dJ22jQQqpoPqhVLccbM3Vv8IYuAaGOqP0cJ/HT76lf8ZBb
 rkreLg7saGVTiUCgrw267M1+ggQgzBYBEF279GZT4OIEyiEFOo6csKrMgUtDZVNkpatn
 +xqZL48+ZyjtkPYEwQRnhYqfEtysMVwkRAq1e2qUPZtAFgNFO98/K/ZfLVz9nm8P+gN6
 IZI9HZYG4H8aN7b2zVNgy+5b4nLVICjwRv/8ZbS2ggmBiOPEQn/LZaRIH2jPv1IImVEj
 RE1KW/DLSOiKMHvgjA2Ngmhh3h67Uw/qClfHzt4aQN/udD9J1N87gaEKyrhCz/g+avPv
 fxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G94O0XqLnIC+MeHyP2qJ5U/I9R13MKboSk6ZeF+uKKQ=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=L5eFIVvCP8PemfnFXfkYOHgPUjKaTNuAIs3/35o1id2prWGAP4rBEifktU963WFdK8
 OTobluL3VtBXLQETcMnq4BiqkqA5ROD7MgV1FsBibSbZdinw/X54WQ0oNeeMyMV0rVHb
 znBY36k08ndD/UTMAQsM/FOHCiULyPC1bJJxblqbpcQ67rBx2Ca6qjpijw8hsIks6kb4
 0NrZGiJ7gOQCwGM9O6OA1lOqP8M7qiumO2WoSSQ36oR19MsG92f+FY6kT2m1P6AicbKM
 gJ91i1AJxFirPlEHitZNYcSOTH2ZVdCSWkSPcQe6XMtRqNipPke6hJjd4lZU+PynhIfF
 MKlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771306507; x=1771911307; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G94O0XqLnIC+MeHyP2qJ5U/I9R13MKboSk6ZeF+uKKQ=;
 b=Wef7jso0ir4JXN5JdQpuHpFv7maaNEk68AeBLAP5MI5C4sZLDzed5md8coPKbmWf60
 vamIz2qGE3Fx99Gl+JOoFxdrB9vxg+Ldr9RJmNd9HwUwPdY42Nl10FL1tdHA2jbXIg6u
 XIaq6l8/9ShycUbRMTXLsXen7vp7ASbgBFJRenozSQGZ7B9kxbvPcGItLyyUm9Ucl7bN
 CdsJWTuTA+qdzq1W3gz7EmV//jLREwqtHZ+VB0Bzi1Xnt/OOQQ98Wcrcy8k6ccGxZbPR
 MAeSB3pA7vos/PiJ9k1c+Xium//Wk/urxaCz4HF3tuhZVEx/hUMExxrotrF/PYvt2+P6
 1qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771306507; x=1771911307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G94O0XqLnIC+MeHyP2qJ5U/I9R13MKboSk6ZeF+uKKQ=;
 b=JKV+vqf48GyftAwlZgRDer5u9DtiLJQID1f6wAPs/3WvKP/sSv8Q9so6LldZShpuK3
 wFLC8V4QDeqM4beudUsQdMkBV6ImuFTByIxrUgLyP+RzMk2joeOKjd4GwT9Ry8Ky5xYH
 A4+cWZKPTqRCvoWplvaW2vvQKxFKd08bcR4bS0m3VCSWmrc1KIkpqWeWYFIytsf+jtFP
 9x2pvFXbPQjJMpCjfnQMKdU+xZPORjfJzpBfGktHN3udMZDt8z56DXA1ALvdNw+0S8xk
 sE5PNRQ44TU0DM0ur3Hk/OwiH5loCVZjemourmUxwZTRWckDreIdZOWmrp3jRylPbti+
 B0fA==
X-Gm-Message-State: AOJu0Yw3wks2S+BXOlBb9mDAbZ8SuKZHSU4MxbLFRPF0rQj40Ja1HQpZ
 c8bdAYjBDDbk/++0/djCoPnY7LtOdphffQIFEN5azgukoeFavdqSLsYx+qy17ZNAtKqUmkDO6mg
 PGCE4n+MD0niTZgRHsH2BuOTeLWT2WJoQGOk47GGK0+bHs7/l6ZAxtJbrBj4KLWOyOvh9oC+QkT
 IvYRr06G8G07O9j9w4T1nspRS2iHHZwgk=
X-Gm-Gg: AZuq6aJLL2RswDiJSZomudTkQantFW6OEDB1BnmSAKTona4keHbqwq/ws6JH+Ueiok9
 IEyg0xe/DegPFrsdKih3ZNYr0hA70+9Od8DJwnG704OgL2FLmWnmrZIeTAMa8gavxlnieywXu7T
 rCCtZOQscYUjyou+cicts/+t+h7yQ9SU119JTMPDqbTm5XJ8WcRJmxlp5PVafa99d2wdCSGarpN
 ix/AbVDlkM2QNt4AxwuO8rLp9WoTYZSyQAI
X-Received: by 2002:ad4:5dce:0:b0:896:f79d:ae4f with SMTP id
 6a1803df08f44-8973f32ca21mr150277756d6.26.1771306507615; 
 Mon, 16 Feb 2026 21:35:07 -0800 (PST)
X-Received: by 2002:ad4:5dce:0:b0:896:f79d:ae4f with SMTP id
 6a1803df08f44-8973f32ca21mr150277536d6.26.1771306507200; Mon, 16 Feb 2026
 21:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-7-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-7-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 17 Feb 2026 11:04:56 +0530
X-Gm-Features: AaiRm5178BhAqTgC99sawzt4fxsre-_U_KL_yX-G5DibbEIdMSS3KefK-cDad1Y
Message-ID: <CAK3XEhPgKZUy_4+=AcSAuSe7ZhKzNsT9oJuhxm7c_CCCM2Xw=Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] tests: acpi: x86/q35: update expected WDAT blob
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 6, 2026 at 6:45=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
>
> replace blank table with a new one:
>
> +[000h 0000   4]                    Signature : "WDAT"    [Watchdog Actio=
n Table]
> +[004h 0004   4]                 Table Length : 00000134
> +[008h 0008   1]                     Revision : 01
> +[009h 0009   1]                     Checksum : 31
> +[00Ah 0010   6]                       Oem ID : "BOCHS "
> +[010h 0016   8]                 Oem Table ID : "BXPC    "
> +[018h 0024   4]                 Oem Revision : 00000001
> +[01Ch 0028   4]              Asl Compiler ID : "BXPC"
> +[020h 0032   4]        Asl Compiler Revision : 00000001
> +
> +[024h 0036   4]                Header Length : 00000020
> +[028h 0040   2]                  PCI Segment : 00FF
> +[02Ah 0042   1]                      PCI Bus : FF
> +[02Bh 0043   1]                   PCI Device : FF
> +[02Ch 0044   1]                 PCI Function : FF
> +[02Dh 0045   3]                     Reserved : 000000
> +[030h 0048   4]                 Timer Period : 00000258
> +[034h 0052   4]                    Max Count : 000003FF
> +[038h 0056   4]                    Min Count : 00000004
> +[03Ch 0060   1]        Flags (decoded below) : 81
> +                                     Enabled : 1
> +                         Stopped When Asleep : 1
> +[03Dh 0061   3]                     Reserved : 000000
> +[040h 0064   4]         Watchdog Entry Count : 0000000A
> +
> +[044h 0068   1]              Watchdog Action : 01
> +[045h 0069   1]                  Instruction : 02
> +[046h 0070   2]                     Reserved : 0000
> +
> +[048h 0072  12]              Register Region : [Generic Address Structur=
e]
> +[048h 0072   1]                     Space ID : 01 [SystemIO]
> +[049h 0073   1]                    Bit Width : 10
> +[04Ah 0074   1]                   Bit Offset : 00
> +[04Bh 0075   1]         Encoded Access Width : 02 [Word Access:16]
> +[04Ch 0076   8]                      Address : 0000000000000660
> +
> +[054h 0084   4]                        Value : 00000001
> +[058h 0088   4]                Register Mask : 000001FF
> +
> +[05Ch 0092   1]              Watchdog Action : 08
> +[05Dh 0093   1]                  Instruction : 00
> +[05Eh 0094   2]                     Reserved : 0000
> +
> +[060h 0096  12]              Register Region : [Generic Address Structur=
e]
> +[060h 0096   1]                     Space ID : 01 [SystemIO]
> +[061h 0097   1]                    Bit Width : 10
> +[062h 0098   1]                   Bit Offset : 00
> +[063h 0099   1]         Encoded Access Width : 02 [Word Access:16]
> +[064h 0100   8]                      Address : 0000000000000668
> +
> +[06Ch 0108   4]                        Value : 00000000
> +[070h 0112   4]                Register Mask : 00000800
> +
> +[074h 0116   1]              Watchdog Action : 09
> +[075h 0117   1]                  Instruction : 82
> +[076h 0118   2]                     Reserved : 0000
> +
> +[078h 0120  12]              Register Region : [Generic Address Structur=
e]
> +[078h 0120   1]                     Space ID : 01 [SystemIO]
> +[079h 0121   1]                    Bit Width : 10
> +[07Ah 0122   1]                   Bit Offset : 00
> +[07Bh 0123   1]         Encoded Access Width : 02 [Word Access:16]
> +[07Ch 0124   8]                      Address : 0000000000000668
> +
> +[084h 0132   4]                        Value : 00000000
> +[088h 0136   4]                Register Mask : 00000800
> +
> +[08Ch 0140   1]              Watchdog Action : 0A
> +[08Dh 0141   1]                  Instruction : 00
> +[08Eh 0142   2]                     Reserved : 0000
> +
> +[090h 0144  12]              Register Region : [Generic Address Structur=
e]
> +[090h 0144   1]                     Space ID : 01 [SystemIO]
> +[091h 0145   1]                    Bit Width : 10
> +[092h 0146   1]                   Bit Offset : 00
> +[093h 0147   1]         Encoded Access Width : 02 [Word Access:16]
> +[094h 0148   8]                      Address : 0000000000000668
> +
> +[09Ch 0156   4]                        Value : 00000800
> +[0A0h 0160   4]                Register Mask : 00000800
> +
> +[0A4h 0164   1]              Watchdog Action : 0B
> +[0A5h 0165   1]                  Instruction : 82
> +[0A6h 0166   2]                     Reserved : 0000
> +
> +[0A8h 0168  12]              Register Region : [Generic Address Structur=
e]
> +[0A8h 0168   1]                     Space ID : 01 [SystemIO]
> +[0A9h 0169   1]                    Bit Width : 10
> +[0AAh 0170   1]                   Bit Offset : 00
> +[0ABh 0171   1]         Encoded Access Width : 02 [Word Access:16]
> +[0ACh 0172   8]                      Address : 0000000000000668
> +
> +[0B4h 0180   4]                        Value : 00000800
> +[0B8h 0184   4]                Register Mask : 00000800
> +
> +[0BCh 0188   1]              Watchdog Action : 06
> +[0BDh 0189   1]                  Instruction : 03
> +[0BEh 0190   2]                     Reserved : 0000
> +
> +[0C0h 0192  12]              Register Region : [Generic Address Structur=
e]
> +[0C0h 0192   1]                     Space ID : 01 [SystemIO]
> +[0C1h 0193   1]                    Bit Width : 10
> +[0C2h 0194   1]                   Bit Offset : 00
> +[0C3h 0195   1]         Encoded Access Width : 02 [Word Access:16]
> +[0C4h 0196   8]                      Address : 0000000000000672
> +
> +[0CCh 0204   4]                        Value : 00000000
> +[0D0h 0208   4]                Register Mask : 000003FF
> +
> +[0D4h 0212   1]              Watchdog Action : 05
> +[0D5h 0213   1]                  Instruction : 01
> +[0D6h 0214   2]                     Reserved : 0000
> +
> +[0D8h 0216  12]              Register Region : [Generic Address Structur=
e]
> +[0D8h 0216   1]                     Space ID : 01 [SystemIO]
> +[0D9h 0217   1]                    Bit Width : 10
> +[0DAh 0218   1]                   Bit Offset : 00
> +[0DBh 0219   1]         Encoded Access Width : 02 [Word Access:16]
> +[0DCh 0220   8]                      Address : 0000000000000672
> +
> +[0E4h 0228   4]                        Value : 00000000
> +[0E8h 0232   4]                Register Mask : 000003FF
> +
> +[0ECh 0236   1]              Watchdog Action : 20
> +[0EDh 0237   1]                  Instruction : 00
> +[0EEh 0238   2]                     Reserved : 0000
> +
> +[0F0h 0240  12]              Register Region : [Generic Address Structur=
e]
> +[0F0h 0240   1]                     Space ID : 01 [SystemIO]
> +[0F1h 0241   1]                    Bit Width : 10
> +[0F2h 0242   1]                   Bit Offset : 00
> +[0F3h 0243   1]         Encoded Access Width : 02 [Word Access:16]
> +[0F4h 0244   8]                      Address : 0000000000000666
> +
> +[0FCh 0252   4]                        Value : 00000002
> +[100h 0256   4]                Register Mask : 00000002
> +
> +[104h 0260   1]              Watchdog Action : 21
> +[105h 0261   1]                  Instruction : 82
> +[106h 0262   2]                     Reserved : 0000
> +
> +[108h 0264  12]              Register Region : [Generic Address Structur=
e]
> +[108h 0264   1]                     Space ID : 01 [SystemIO]
> +[109h 0265   1]                    Bit Width : 10
> +[10Ah 0266   1]                   Bit Offset : 00
> +[10Bh 0267   1]         Encoded Access Width : 02 [Word Access:16]
> +[10Ch 0268   8]                      Address : 0000000000000666
> +
> +[114h 0276   4]                        Value : 00000002
> +[118h 0280   4]                Register Mask : 00000002
> +
> +[11Ch 0284   1]              Watchdog Action : 21
> +[11Dh 0285   1]                  Instruction : 82
> +[11Eh 0286   2]                     Reserved : 0000
> +
> +[120h 0288  12]              Register Region : [Generic Address Structur=
e]
> +[120h 0288   1]                     Space ID : 01 [SystemIO]
> +[121h 0289   1]                    Bit Width : 10
> +[122h 0290   1]                   Bit Offset : 00
> +[123h 0291   1]         Encoded Access Width : 02 [Word Access:16]
> +[124h 0292   8]                      Address : 0000000000000666
> +
> +[12Ch 0300   4]                        Value : 00000004
> +[130h 0304   4]                Register Mask : 00000004
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

looks OK from a quick look.

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
>  2 files changed, 1 deletion(-)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index 14b680debe..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/x86/q35/WDAT.wdat",
> diff --git a/tests/data/acpi/x86/q35/WDAT.wdat b/tests/data/acpi/x86/q35/=
WDAT.wdat
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..e1e056b390e51c49f11f7b0d3=
5e4e7c55d8067b1 100644
> GIT binary patch
> literal 308
> zcmaivF$w}f3`JkEx{TV)5#kX9FW|0)oq~c}T8Xtc(2GYhPO+$9AY^#?`OH6WH>b6L
> zth#-_J6bm!dNVTt;vLff$K8QJ!5f$W4`2?6f@Jj4QYvm-AjK}Dx5`T;m_2{<;x*QX
> lL4w7nzVfzt``kzV@waK@$$at15&T;93Z<9T{~wRc(JwJ97XbhO
>
> literal 0
> HcmV?d00001
>
> --
> 2.47.3
>


