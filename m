Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DE0FED9E4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2WWn-0000IC-4h; Tue, 17 Mar 2026 11:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1w2WWb-0000EF-Tc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:40:06 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1w2WWX-0002Bl-W9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:40:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773761981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k09jF+ysIiYUdNtsndhBBiDA3NuFRghsCi/rhnW4QIziWDb+k0xwLL4DaDpDmLHuyMep5dmxABw/TDuYWUJZZlhCXbZWgQYW/+O+LDOmCDdMuCUDs79fUIEEle62A9QPs3H41lrftX2dn7yla4quQtyNUjidVwDMd5hSa/47QPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773761981;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZB/uvtKZzvZV1yv1n6o2ud5+quoGELlzUGFS6nwlLPw=; 
 b=Z5htRPbqlB2QHwHzp4FxSv3aRiVmCx1mFba8rNyq3CKTPFVo7CSzzEtaWA8ThUZW5x5Mmj4bi4NmCMnSahHp4u3segGD369CuPXfax3jAkwVnU593rgIJa+VHBEsKw3ExmxsuBoVDcn9+cbNeGFOAmt04B6kcMvhIsNMZS6Rx3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773761981; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZB/uvtKZzvZV1yv1n6o2ud5+quoGELlzUGFS6nwlLPw=;
 b=Sl8Se+ZnrIypJSQ4U0MyTdS5/akDytzd1NTtpN1F6pqb0vL6YDnc1pXxhIc0mdjV
 kTxcMc/QeYJSe+jKbRb+nbka1g6GKulLMvBt2XXDkBqMZASPbjVo8WzRnfIUb/X3wkG
 sbSx72C67dH+Wh9wy4c1Z3p8vE+up2QUsLwPRLdI=
Received: by mx.zohomail.com with SMTPS id 1773761978426936.542075208032;
 Tue, 17 Mar 2026 08:39:38 -0700 (PDT)
Message-ID: <bd47e650-9ab2-4adf-8810-d4a8624e3363@collabora.com>
Date: Tue, 17 Mar 2026 18:39:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 72/85] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-73-marcandre.lureau@redhat.com>
 <9a0eda08-0474-4283-8060-e8b31193ed59@collabora.com>
 <CAMxuvazuUAzB7gU1RzAgf12WEQHTiF86Z1R8+dZ8CE7noEvRgQ@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAMxuvazuUAzB7gU1RzAgf12WEQHTiF86Z1R8+dZ8CE7noEvRgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/17/26 17:02, Marc-André Lureau wrote:
> Hi Dmitry
> 
> On Thu, Mar 5, 2026 at 7:55 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>> Audio (driver=pipewire,model=virtio) is broken/distorted on staging tree
>> and I bisected it to this patch. Can't see anything obviously wrong in
>> the code, any ideas where the problem could be?
> 
> I can reproduce this. I'll look into it for rc1 and let you know.
> Thanks for the report.
> 

Very appreciated!

-- 
Best regards,
Dmitry

