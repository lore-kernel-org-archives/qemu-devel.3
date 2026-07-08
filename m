Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC46BC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUXw-0007r0-Gv; Wed, 08 Jul 2026 11:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUXu-0007qD-RU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:50:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUXs-0004fT-Fm
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:50:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so542916f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525842; cv=none;
 d=google.com; s=arc-20260327;
 b=R9N2aQFBNtgr22OeeuybKKcmPBtSzc5XercR5FVbbjLhw2/f1llnHx9uJe4zO2k6KV
 /xAtt+SzbzMp9dZUS1MGb4FSF2Uvs6Xh6f2k03VYQDVrtdrc1pdZwZKMIGRdcSjHMYZ3
 ok1AtAiULfV9GBnOjze83Ap+jVxvLr80uUHRU5IXb5mqb3Iypg2L3vjWWB/+AkCRIEzr
 dqWYnQhM+Na5t47MH03k4jGgD5QXUH9mvBzdO5aMEdkJjKlaKqiA3zD4rcaSlbQRbyhW
 +msoEHk4GmQKbG8tL80lpevmagfjUb7gf4bTDNdO1J/Mz095iRujFziuwbliLHJuxUnS
 lBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s1OcXkWo3gi0kNRhczX4vcOTua6igMSJGEphn7JACdY=;
 fh=weeZ+I/k7h7EVcDy63vo1ai172Vh7g4N1CNTsRAlT80=;
 b=IX04O1h7o9HN0VJ4Ni267CNaBDS5p9LEE7FlZAZQsX/cPycH9JU2+GVqUJ3D+ZBBTF
 Yx9P8P5xSfS3HQHIbfb1Qx0wXhYXGDAimPbSuuqlvCOC8TBNbqAvkmQJiy6cmQgMoLwA
 L9zYqZJSMDNsH33gZHbMnf0Mh4+l37rOzJc3IB0suHa6E1JuMjsN5pNQw17uEMZsQ4YH
 u07T0096ZaQThYXQ7XqGsZS9jXj6V6JTsgDECZtOUm3/CIHdJ6cm6bMIkEZknDnttTWv
 D8iN+rPpZqpnFlnF5fhP6rpWtv8wET7DhDeAlZkXbkOhQnotrLBOkMeRTyp1XNtniQeE
 oSdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783525842; x=1784130642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s1OcXkWo3gi0kNRhczX4vcOTua6igMSJGEphn7JACdY=;
 b=UidZbX7wsQxdndOGb77GaVZu6TWH84aQlYjy2eJmPSNXyceQnpKXlnpeNnOUT+Ddru
 IjYoL9TS9bMjtsa3nA0kcGfpnc5nf2Ne4pkzftw9dBgVsoNcJfbZBcE6DXoC4muYQcGx
 +doSiqACGs0D7lJeu0Iz3S/A2Yv2iJFQfIBLEEdmr9yZsciPPmCwQJkj5ShHF492YhYx
 moiQ4eYY7G8a4CsbjD0SWOteOF179+sqgd2rrzLWb4XustYTEgQIfK0cPvE9jcg1tt5h
 jO62LOYZuk7F+5JeCXhzH0HQcVR83oI5ZRJzb8Io59WBWjrudermieN6x/NbtzpqtMgc
 7IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525842; x=1784130642;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s1OcXkWo3gi0kNRhczX4vcOTua6igMSJGEphn7JACdY=;
 b=opOiU/LdeiJL88j+GmL/wOqqy0QEcsZW7yFBMBiSEvFros2jag1k3XmOFvjvhOJVmS
 /Jb8ybfxDC+Q8t42sd4WLoNiIDcuR5zjX3Ncaiq0H8jFtkh+g+dODKpVhKJCc81XwGne
 26/tuMFDnn7xdFeYa9vOgFm1APXK9MULHVJL/utG1Cy/eVH9L/5keXmfJ5zmN8H7ccwr
 Tbi7qFcbNcKbZ91SKB5Y0Hcrp3AYAEZYJwBxl92PxpJIC5DsyTpMc9k7Ee9ufoSBMT/H
 XfKdkx0MvRk3BfoLt4lJTytitNMNm8+VuDdWbofSO9tMPCJTcWtlygjK6Q6mVdhcvHz1
 JYSA==
X-Gm-Message-State: AOJu0Yzz/J6MC0ya1x235TfvqW/gOfWmpMHnZ3crFVEWqkoSYBer4PW7
 7spmepldO/mNGPbeZH1Hscml82V0hr1aCVt/l5vFBWyJPUWXCKAkHn5ATZNAqswTqgC1ZxmLFKu
 CM5/6t8pSA6lKxU8hP1oIYv0KMoqadh4=
X-Gm-Gg: AfdE7cmDgb2RVs4nsXNRGEGtWGY9CV263J7cR4AQofp08NO4lRjc/hgFOO5d0Nx5wIy
 v0IiLNUK1VayoqBIlbDqdGznd4ZN5PcOHOI1kz7LridwsZsBl1p213zFGo8GH4NKoSDIZ2mBrnP
 FzFRdBhmiLlKJS6ih2ebYHhRryzewVMz+PX0S5ODENhUFOM50CzO5ohqd9+T4v74SecdfdXU3i5
 G0SdcaDsLc9QQHfg91ddLaclE0x23doMQrDXLSTPcHPyyiRp3KSh1sWkZisUq+cQpVAIcyRt+wC
X-Received: by 2002:a05:6000:4705:b0:46f:7d90:8127 with SMTP id
 ffacd0b85a97d-47df07ae289mr3654527f8f.13.1783525841974; Wed, 08 Jul 2026
 08:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260627154225.863984-1-bin.meng@processmission.com>
 <20260627154225.863984-2-bin.meng@processmission.com>
In-Reply-To: <20260627154225.863984-2-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jul 2026 23:50:27 +0800
X-Gm-Features: AVVi8CclZ5Wbxc-qEhKBwJh8Ujz5Rbqgv4D1IXG_AtBheHkub999OV380tI7kSw
Message-ID: <CAEUhbmXe=aJ+K8isdCpdFn9Y4LLTf9SARY7VaZoMo39SeYJAcQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Jun 27, 2026 at 11:44=E2=80=AFPM Bin Meng <bin.meng@processmission.=
com> wrote:
>
> Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
> in terms of ZynqMP PM firmware providers for clocks, resets, power
> domains and pin control. QEMU does not model those runtime firmware
> providers, so using such a DTB with -kernel currently requires users
> to edit the DTB before Linux can probe the boot-critical devices.
>
> Add a board DTB fix-up for direct kernel boot that removes those
> provider-only properties from the boot-critical nodes and rewrites
> their clocks to fixed reference clocks already present in the DTB.
> This keeps the user command line using the Buildroot-generated DTB
> while limiting the compatibility adjustment to devices modeled by
> QEMU.
>
> Document the direct boot flow, the SD and QSPI image layout details,
> and the remaining firmware and real-board peripheral limitations.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> ---
>
>  docs/system/arm/xlnx-zcu102.rst | 139 +++++++++++++++++++++++++++++++-
>  hw/arm/xlnx-zcu102.c            | 109 +++++++++++++++++++++++++
>  2 files changed, 247 insertions(+), 1 deletion(-)
>

Ping?

