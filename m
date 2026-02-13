Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9545EDF14F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqPh-000062-5l; Fri, 13 Feb 2026 05:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqPg-00005J-3G
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:28:40 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqPe-0000LJ-7U
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:28:39 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ada2c30a1so717629d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:28:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770978516; cv=none;
 d=google.com; s=arc-20240605;
 b=kw1WaCNCcx82J/6aydlj15j0oSoX21hHh1llYxHJx42JJ1Eho520sD7Ovdm/4nUTNi
 kwjxWycSLwhE9qtUij1DQLB+Fjlt7yXIAyFWdRTmT38eoZ7hG7jtBxfDCbnP3WmGNOqi
 GCpqg65lsIhSV8HPYuV94H8W+1d+WGmrlmfk3iZp29pLMCC6keB7KRuaa0nOKsShe2Ks
 s5tTMlZBd4VZ89welCJtVLpYvO/9fYIzG770f5QpXWw8KTUvNPGAVUAX+hnzUAvWPJRA
 5BBaLmKC23Z+Z9gK4HcxRI34v5Jgor/5UzTpc9He/BiaNKYwO6e7NL/geT1nelN9RfiF
 wmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rCjLomqP9LAD6D1qxXR3cwScjETQfo1yjO0XeRDdrlA=;
 fh=PyOPoNBoQFM3aCBquwILiqFzLPoaTRIJM+NDP7vsKXo=;
 b=WBS16WKUXsVkMC8DLIA/S0npo7Lp2RpJ0V/wmh2hTCRvM5hN2fYKgDDuAMsmXcbvAu
 7+8kzg2KkwEsfYaaBNvG4YixoZJ7Ca1/KvGAjklnwKvVp69aRpvpq7kHt/SIJFX+E1Oo
 qI6ZWMYzWimCHLabGT6PAvAaX5Ao+kSGAiTH5WXr0MizrrnzZS3KUJBsR8cKsZlJBZHr
 X14qCE8H6k46qOhPPyiYRZ2xCdnpnOSE1jy7SGxVfI9YpoASnHWG87IaHgZvkulSWCE4
 pbTvFuJYxzCgboWdBXr8NKf3MNIU6C+rlLwx89Av6CY9JPzrKQg8wDloh5RRbq4ETHsU
 04fQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770978516; x=1771583316; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCjLomqP9LAD6D1qxXR3cwScjETQfo1yjO0XeRDdrlA=;
 b=Fd9azK6HAFBFJIBopA87AcWskUK444BHECtABl+mrPq128z9giqbJJM5bEzq0olvjp
 zpai07rBwc80xE/Xa5RwyOqvtxO8OSWqoWAaO2ekKW0coanQGG02FzI7G1IP04kfMgm/
 onNys0hgWan6CqzecFlzYlgIVxKWgvHGQC5nNmfb8QyQhbeRJR6htxuXpmbg5AqYQn6m
 QpLCIa1IaHMRPgK5hvGdmTYPxZTVIHt9M3IaQeTv/CxhbZcr272nx9E5FThuO+csi3se
 jI3xPa1ypfapK/J6RcH/NYDAqEsys+4zok6IrSOIDINsZzJKCCnzN8vpRv5MPOGv4VJF
 xzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978516; x=1771583316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCjLomqP9LAD6D1qxXR3cwScjETQfo1yjO0XeRDdrlA=;
 b=SB29+1QUjFpOLb+NSB3vqHoccleC/bUa5pJrluexcDJECm+5KlkTxaDXlDPsAndHO4
 FwvsDALqztVohl/dkzCbBsOSnLqT1Dspfy6DQDzLt3pDjp7oWnsz3E8JsQ70wDENsZ05
 SMBEZyBds9r7RQFeLB2x8RZyxMUoP+4vXYDlPI0V601NIbbxYMPBa/M+NwZO+qyfYaJP
 Z+gNpqO3bpyMVzPLPzRLknb1z8cTWgmZG+dvJzepTg4rG/YYWe6CwMUrleTr2rJZU0Qo
 smgmW6UOYYoE/kwpa9TCBUCKmzXu8AuW3JzYz6EOxIzDpXWFyAt12MB/Wn7dA8i5qWbx
 12PQ==
X-Gm-Message-State: AOJu0Yz4nv24BDlLda+NWgIteLxQkJhOlHKuHqGguVpunLQLlx2klR8D
 QaF4uKmpVv1wMH6XgfOaa8069nawqvgMtkEbzNhpF6EUcyvVrWYCXbjJhD8gyYKttFIqB5HfPeQ
 fVhb3QmMmHHI6rokcrSU+fJ+LOEXX5JJzwIKs8c9xgw==
X-Gm-Gg: AZuq6aKNP392KpiKI//hp12u82YYu60F7gGy9N/Se5h7oceScINE2Txvj8fAF9LIefa
 skq2wUx5EhCHkb1PmqMuGQk/bcjAIBY9wq3Ay9nH36nVXb4Mx0tMdljG9gzCfVEe7a8IgcdZTIN
 4SUrsn0vZrPiwLtvZZ3gvH5xpcK4vxVJ2w+oLRYUEZ5uxUAxpIiZ8olTKcUF2nmqrUPn4o9bLzc
 HiswXMD+0fAYLWR5mJM74MRB7IC+w8MamN5CO/mrm1IuS29D7L9WEC+UsT4zEFuOY096kni740Q
 7tfLbz2NQo+rSkOF82QpnlLYoLhpbzIjlm+x3A1Y/0tb6+/mGQYe/AU6Ylgb2oJBz+o=
X-Received: by 2002:a05:690e:d07:b0:64a:c9f7:9fbb with SMTP id
 956f58d0204a3-64c19b66443mr806026d50.89.1770978516184; Fri, 13 Feb 2026
 02:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20260212174103.504520-1-corey@minyard.net>
In-Reply-To: <20260212174103.504520-1-corey@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 10:28:24 +0000
X-Gm-Features: AZwV_Qj2BVBViOKNAVXOt9iaAUFSoOZ68Htf3m0GqQbRX7O5s-lI1JbuQ2LSNPQ
Message-ID: <CAFEAcA_de8ff_sBK0r0VX867A6D86mw4+c-SfNDbLXUCukLs2g@mail.gmail.com>
Subject: Re: [PULL 0/2] Add a fake IPMI LAN channel
To: Corey Minyard <corey@minyard.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yunpeng Yang <yunpeng.yang@nutanix.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 12 Feb 2026 at 17:41, Corey Minyard <corey@minyard.net> wrote:
>
> Apologies for not sending this in the right format.  Hopefully this is
> correct.
>
> The following changes since commit 159107e390609f71b78268a4888563dcdce6ac65:
>
>   Merge tag 'pull-hex-20260102' of https://github.com/quic/qemu into staging (2026-01-05 07:35:40 +1100)
>
> are available in the Git repository at:
>
>   https://github.com/cminyard/qemu.git tags/ipmi-add-fake-lan-config
>
> for you to fetch changes up to 75c15651af1b2553ff292553545f7a6a56c32932:
>
>   hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config (2026-01-05 13:07:23 -0600)
>
> ----------------------------------------------------------------
> Add a fake LAN config operation for testing
>
> Just add the commands, the proper data that can be set, and some tests.
>
> Submitter ran migration test.
>
> ----------------------------------------------------------------
> Yunpeng Yang (2):
>       hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
>       hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

