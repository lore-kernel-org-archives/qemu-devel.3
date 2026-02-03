Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D987E8B381
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPUK-0001bV-0i; Tue, 03 Feb 2026 18:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnPUH-0001bH-Mt
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:07:13 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnPUG-0002G7-5x
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:07:13 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso3887048b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770160030; x=1770764830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dah94LlcgxIBc11yFC7eq8mtegbkFcb+3zm6NfNIbTA=;
 b=SRVK04GeemLz2mvqlw/G3ft/L0wb1RsIR9IKQjKBm4DExn40nL00qejLI5eRfCxwws
 Tq/6yxvMJKwwc8yn5scW+BWtKDDBQhlsuGia0b/bFIAA+H9C6ErIKjvkeN885ZV/SATT
 wOOrLTA46oQPnwilXVRcEBCLWXU2JRFziwgcgz9gfuSEOuPGhNSl9SQyZOW07t/qzuJ0
 W7b0ZIFnAjMDlLUmcJW6Kmu+9XoyYKeVMxaqXW7OnFWjCgC1U6ZmVb6TIQbjSbNnK0dt
 68UX54fDhs5brNhbuKewmH//e3Z2FxL93Eyz7+Mzxq8lhJWdINv8MhLpFn3N6UIAQy9o
 BRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770160030; x=1770764830;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dah94LlcgxIBc11yFC7eq8mtegbkFcb+3zm6NfNIbTA=;
 b=EZp53dOgDotsmkF7kms79gUSmzooPJl8d6LDaoGLU7kWtWS0rexZEVhfY09hJvsCv1
 9wRdtky1nx6Wn4JBIjfx+ko4lTRO+4QiuXDM2Ddxvge2DaXi8afXaAxWsbYiFA05aRRE
 1xxD551LfI6ChUJe4nAzaHhLndBJfUuY9DPAWELDqDaBs+212783422tFRGadv0G7pZI
 oPKLoSRD3QYfZ0TO+s5yJCJJZnd+Py53ozw0DU0+fvC/BZkE5Lwi2L1Uqv7Jb6NGwcM2
 1HjzfiEwrl06Dkde9wZ9epQNLNDFyD0DZVbtlTAjGiswj0wI7pY2+aQW0ktf84p69GX+
 YosA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlpWs3DVruxm6SsK3RTsNX+FSaj1nEFAGd4ktWHXdYdiR0afIEsLC4RanGvVp1sLmXMC4ZlcCOAapk@nongnu.org
X-Gm-Message-State: AOJu0YxtALkV31zdbjIme6dS/Zg4hCfwfoAbVKG4Z5YLKxowVX21ZO+B
 BgghXmghafL+CXRPZlqA84hnru0DpggXXgZPDfQmrae3J2gdj1ryNzkDP9QmQkMjwiM=
X-Gm-Gg: AZuq6aLOF52Q3/w0bOudBK6/rzkVe1v6FLelKksf3P3oYKoc7+0Nh37yMybiSyIAgyn
 dNZyM0DXOZZA8u4iSlgXmsFpdfFCrLxyZQ6xwSroxKZsHusx9eADSIsXxVxZCBxB9OmCi/dkVg1
 FlPg6XHkm1XQ7zEFRyoo3eltTgQi0X/oFxs6niFa2TowFSRJb/pO+TrBYKFBsh+w5MNK7W3gYl/
 wZkrdf3LDFEAve95YIieonyB2rsGijTGs36RL5kzgnrys4QC1mHC0oJnWuR+92XN+Cv+6fIA6Db
 TEV1XwvlVr0Fgmi9VyTZSeiVwTPR/tGeKs06T0wfdyKRSypJmE6GkHs+TuX6TVw5Id0n1tnXZFw
 l0+V8ycQE4M5g2WRwqb52E/IgITdsU5UuqcnrkaqpGW/9E2oReRuLciKT5TIIkFhb+Du9eRJC2o
 vS0iDjDITC22aJcDfEx6ILPBNm23P/qR3Ouq7osR7ywkYUdOdcv+zOymkfAPIMI5q+wCg=
X-Received: by 2002:a05:6a00:cc7:b0:822:6830:5900 with SMTP id
 d2e1a72fcca58-8241c1f5796mr904211b3a.6.1770160030429; 
 Tue, 03 Feb 2026 15:07:10 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 ([2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d4abb49sm362926b3a.64.2026.02.03.15.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 15:07:10 -0800 (PST)
Message-ID: <acfd1479-3b6c-49a1-9bb8-cf1bc5611f87@linaro.org>
Date: Wed, 4 Feb 2026 09:06:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Firmware 20260203 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, kvm@vger.kernel.org
References: <20260203120343.656961-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

On 2/3/26 22:03, Gerd Hoffmann wrote:
> The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:
> 
>    Merge tag 'hw-misc-20260202' ofhttps://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/firmware-20260203-pull-request
> 
> for you to fetch changes up to dea1f68a5cd338b338e34f2df5ecb2e35a9d8681:
> 
>    igvm: Fill MADT IGVM parameter field on x86_64 (2026-02-03 08:32:33 +0100)
> 
> ----------------------------------------------------------------
> firmware updates for 11.0
> - igvm: rework reset handling.
> - igvm: add MADT parameter support.
> - uefi: variable store fixes.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

