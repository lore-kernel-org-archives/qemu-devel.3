Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1719E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF7Z-0001qK-5W; Fri, 13 Dec 2024 18:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7L-0001ns-IA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:30:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7J-0002vn-Cp
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:30:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso2180098f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132639; x=1734737439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g7fvn8USEKMq16SLa2wUNwg/HO1Jl6iGLjfEKjPyOMg=;
 b=RWby0vRBRb7tMQVZaHUYmdx67oVe+N071IXM7dP2ecQ+pg8iX+zmEPZLlbmb+J8Pvh
 KAz7CSn3xbHfxxWo6b93DzlDhaDJ0ZLVmhghr5wUggyaLxkPVmKD5XFfy2hwwg0k+mQg
 seeLyRmCXMFbn9Ox2gcGFb1R39oeBX0kQqkVNW4VtRkeYH/1zk8Tt66birFuS06AP2Tp
 sXjZ04Gh22taIz/Ly4S8Lg2XzFhkOwfINnl1U7h9GrX4CrHHp9GikwcwydyxOYvGprIN
 1TuxHXIYPtxD2naeI9gNDyZ9rlPTq8NAHYDQAogSFqY6N0+HJuzTLPllkvg/LEqVjrI+
 9U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132639; x=1734737439;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g7fvn8USEKMq16SLa2wUNwg/HO1Jl6iGLjfEKjPyOMg=;
 b=UVchIj6UDEd8CeMEXIAaQA6pZDYsW6RznzJjACfwivS99inltfJfnUgO5tcC9vQ1U7
 5obWstmlXuvb9TJdt2iceG6pOntd4wd6vXugF+vZYmarFm8ixHSkBkiywgmHdeKUCjr5
 NVNhYFDv5ik3w27QsgFwhFUDyHJ/7L94zz2wFXsxZbjM3G7iBixi6tHiU5wQtOjFOCB/
 LGTnZq8+CvrCjZalo5mEde4SIMFnaQOhLBcqg46nT+8eHDd2jDS5BSt0c3WajGdVfXCM
 5T7D0CuizOWF5xlaJA8g7+1FueFybMSCtFiH6UFa67Ru6eKiw9hv7EIl+QN2XaUryqBA
 OT+g==
X-Gm-Message-State: AOJu0Ywh/HkV6rdHlIPXREsK2bXn2AkdVBe0c49qxVEx5fjXtuT89v0d
 jlnHjxPwGBEjD+q9Bow6jCXlSdY2SFBhjKufVUfwJdk1pavOxzs/8E2aPO1pzhQ9yiUWfTiTYVU
 F5Ls=
X-Gm-Gg: ASbGncsCOOdIeB5esc/ymqbiqwFwXM7Z5yQED+aTTK9TUeHVQgZ13art7tgzMBi9vLF
 pmo+FWMnf0eKTt7bid84Y3suWTIF1aMIPPLB4Y4KFaI20x+wdZmmCrpDWpsf9PYyIRj/aEwUpCn
 XZeH9tq8Sc4izQVZNkGr7cDe+THam/wOTjhwlR6JrdWt6fEMdctgQ6EszuKJtC3kD8xyyrR+Y4u
 eW+g+i1kVLvOsfCn+PoiECI0iFdaJM6M3rvpq3QA3yKkkbdhfwVaPWCjLQljQMQdTx/Mg==
X-Google-Smtp-Source: AGHT+IGyS0rVLyg/IlTwnsRMoJfyaTbR13a9JlkFswsPPhQ6qJj9qQL/ddXx90NHWDPSn8yS7bGGlw==
X-Received: by 2002:a05:6000:795:b0:385:e5dc:e285 with SMTP id
 ffacd0b85a97d-3888e0c0699mr3507368f8f.58.1734132638984; 
 Fri, 13 Dec 2024 15:30:38 -0800 (PST)
Received: from [10.1.1.253] ([45.93.146.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4363601406esm7328355e9.3.2024.12.13.15.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 15:30:37 -0800 (PST)
Message-ID: <28aa18d8-5015-4fa9-aa43-f988c591b200@linaro.org>
Date: Sat, 14 Dec 2024 00:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] hw/nvram/fw_cfg: Move PCI bus methods out
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241213133352.10915-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 13/12/24 14:33, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (7):
>    hw/nvram/fw_cfg: Rename fw_cfg_add_[file]_from_generator()
>    hw/nvram/fw_cfg: Pass QOM parent to fw_cfg_add_file_from_generator()
>    hw/nvram/fw_cfg: Skip FW_CFG_DATA_GENERATOR when no data to generate
>    hw/pci: Have PCI_BUS implement TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
>    hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
>    hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
>    hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()

Series queued.

