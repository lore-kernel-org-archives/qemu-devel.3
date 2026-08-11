Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0269DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjub-0004oM-UX; Tue, 11 Aug 2026 06:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjuZ-0004nn-Pa
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:40:47 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjuX-0007Oc-17
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:40:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81ee6b2da98so40522117b3.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444843; cv=none;
 d=google.com; s=arc-20260327;
 b=ire0Xp4Vi5rHZDAUYQ/qL5qKrsX5bBTTjpkdhB2cfBb2QaL5TcqqlHCtRaOfyeG8yu
 cJKs5JnOT6evU30QzzMmicek0PWixjNNVtdg2pbbVN1pNG3vuO17maYsX8qsfQVsbUYc
 qOZo00+vld4C51oP0q9fFkG9kFIITK2RNdPxd3YlZ+jp1FjXtkZErUd6QM3F1KpnQhs1
 7qKsKfP8azUHC/odDtNWQFXSkkGuaoaaG+wC2xwEcCDXD/kW2xylqD/C4N0mOqoF2NhL
 1iGDptA9CETT0LaWvn5WAMh9U5bZGTJg79WWl1roHOnqiDT06+ICZpciNtkZJz8hUAF4
 lu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8VCQ1mJhXUi8Do29pZP6KhrLWhAThZO+A7xqOWH2u8w=;
 fh=sFCrn1mNZa0xOnZoQSP00hsrUs7LtiQds3ElzCDFvgY=;
 b=axZ6taKc8dmDBSqK2RtrySF7lKqxhy22sHNiszWs6MhKaefcl5S0Ex+2nsylKfO9zS
 DjTw2taqj7+NaoIsPnDF0OQCyYGuJU1sXsq5JQOSOHA54rn7bU4mFazKFPmSDHt/y1wY
 RkciiN5Ca33MTf+v+QgQy8JcJaiECr14HjM6+JdcfPDBScye7TMqEv2EHZ7gQZ71O0j4
 xvCRYpeuTK8maDBt+R4McK4KBmwJk2kckcwi1sBUFAtst/5P2R2uoADA0x6PGIhsc5EM
 7l3XUgv/X/0gBYchWTeCqQbUlksWfTDHHDufTWKuQGDl133JXyUB6I0fiKFGWU+nKWkK
 3b1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786444843; x=1787049643; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8VCQ1mJhXUi8Do29pZP6KhrLWhAThZO+A7xqOWH2u8w=;
 b=ScYr8gXEiRsGxXU64r54s2GbWpYhfYBBPvdcOPYKr13wkCIEG7WJSX7QGD0iqS8jh4
 rNKgfcZPZLGVeeYNA3JL9FuFzuruBSOFFitHz0pwaPnYbFDEpUwTr1gdML4L5tgzdmH0
 TJWtpDx7lfPCLZKw4QP4+EkuO5uCRQDqwrQhhDwIyT3vo8PmuOCPAbMLlBrJEW4XDmIU
 +gwLzKqZTiyWgFvnpcNearEkn+AGrJaf30JUycZSU1fefADl4Vwd6ek2tFW+fmmNvdUh
 j2TGbuzsJNWePwWKjzhynA20g1cfHPU8n/1L3ycPMMZ5xt296yFCc+BWZF6bjUDt+60M
 7ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786444843; x=1787049643;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8VCQ1mJhXUi8Do29pZP6KhrLWhAThZO+A7xqOWH2u8w=;
 b=hXbW1ib4PuRyW00i7HgkSi4QN0dBdcJjUBhu6hhPK3JtPRzwP1vkTWXYSn0zHUMYgt
 DJ95nBEL72tH/EyuVXvyLUUrLG92zMZ+KhqmohOZuODzQFcPSPIG4Flcf2xGRURF3G9u
 CpldH/jhW9rbjUAK0TD8SQYWgDmXqhZ5+pz95IvAEP2eUcYSL17TlMFfM8H9QRgciU11
 6rDphYmZ+Hoq/pADoh/Cpk1NH/ojTp07iklbJimwzs+kEYbTNxfr+4itHI/W69hrBeep
 sAOX9VRm3hkcKE143vNERRighZcq7nMz7Y/49Aq6TEmMDohs32yVUDY0ajNEGJIBG27F
 TYsA==
X-Gm-Message-State: AOJu0Yw2G6TRGFaepQIhKoiMJIz5KRzplxuEwt+emvvGFaTioiSe1f4h
 leaf7fkNYIVnjmuGkljfpBRQoNctNfXHWT7f0OKXvcsu2KEWVIzIjCl7i9WScdCz4MrLJMwk++B
 B91Rv9AcWjIAFsbep8bNEi3ErLrHOLeHYh6wVIlg2sQ==
X-Gm-Gg: AR+sD11S7XJkkV0neRneIxH8Pv2QR7xhLM5b2tfUR9IYMiGF1Wo7IenHenVHGxlseSc
 N6HN3WbvpAkKc5+tkIWp5lNl7m/XvJFyEvpPZoRJVCCMS+A5Jk/Lidacb6MmEI1/5E/rhEodkuT
 wIbQDlb6IChlqKZuXYP3zMqnlDf73Hw+H2KTcR2/vQqEpT+dv12J5glSeor4LF1GkDJZYJDvjix
 59IR+G/YPq80ONlaMuYisG7xerOOIsQgsGy16b1KEyKdBIipDttnZ2QS1pDn3SnjHKsz8qceZgJ
 ddwLSVhmQKCh9G4UOLZgL8UvR8eUCYgTCpsabkqYYjdT0ZK+K1GB+DTe4yplCbyDE7kGoFoA1ie
 3nlO6m//Q/ohqc3VvuC5edu7GyMiv
X-Received: by 2002:a05:690c:6a01:b0:81e:f1af:f78f with SMTP id
 00721157ae682-82f2f6e095bmr14613077b3.26.1786444842941; Tue, 11 Aug 2026
 03:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260725124231.86233-1-marcelomanzo@gmail.com>
In-Reply-To: <20260725124231.86233-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:40:29 +0100
X-Gm-Features: AUfX_mwkQh2Olo5-46IMzTu63kn63zCwuEM-kwmFCLB2qWF3swwsTk3PbeUhOdM
Message-ID: <CAFEAcA_Jw=CKKpXMfmEby160SKvCg7p026RdLdQcpQ2gA59-ZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm/bcm2838_pcie: make PCI device enumeration work
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, 25 Jul 2026 at 13:42, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Follow-up to "hw/arm/raspi4b: working PCIe and GENET (real
> networking)" [1]. That series got the PCIe Root Complex link up and
> GENET (a plain sysbus device, not PCI) working, but nothing in it
> actually required a guest to enumerate a device *on* the PCIe bus --
> so a real gap went unnoticed until now: attach anything to
> raspi4b's PCIe port and "lspci"/"/sys/bus/pci/devices/" come back
> completely empty, even though the link itself is up.

> Marcelo Manzo (2):
>   hw/arm/bcm2838_pcie: make PCI device enumeration actually work

Since bcm2838_pcie isn't in upstream yet, I think we should fold
this fix into that patchset, rather than introducing it in a
broken state that we then fix with a later patchset.

thanks
-- PMM

