Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4D3E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYIt-0007bM-3u; Wed, 08 Jan 2025 10:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adam@rttst.com>) id 1tVYIr-0007bC-HO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:49:05 -0500
Received: from mta-232a.oxsus-vadesecure.net ([15.204.3.6]
 helo=nmtao202.oxsus-vadesecure.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adam@rttst.com>) id 1tVYIp-00040S-M8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:49:05 -0500
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=3@204339 smtp.mailfrom=adam@rttst.com;
ARC-Seal: i=1; a=rsa-sha256; d=oxsus-vadesecure.net; s=arc-202309-rsa2048;
 t=1736351339; cv=none;
 b=Js+LIvAdGBVbmilpCOtB7E0DIBM+HDKJC+azy7LxVSlpEN8JhxuzDmqVtvtD1o8v1bfKKKu940Bwux2fk8rLsTiTt32KY8f7ia3Xuji34zMCDXGH+HbbRBSUvBRTurTDSi34OKP1KJuc7uRdpnBUVjLTOA4FFEtz48kt9aSFjVbu4FCyejeQDhWY/CgCzqLkjiL/WHyp58Byqe5mgBoW5nCmeRvChHUgMUSbB7GM9sb57nitk5B6ZngSwF442NXgt6QZuWKD77zgnFUUf+nYiUiciVF8acrHvAQ1/qbtNxKVUfb4Z2a6f2b57YiqP4Tcs47BFsWuo9R+uGILJItIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=oxsus-vadesecure.net;
 s=arc-202309-rsa2048; t=1736351339; c=relaxed/relaxed;
 h=from:reply-to:subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 bh=XQJflwps/MuD7o/roO/TJX9kQzhs7ZSpG3554A8PasQ=;
 b=Czs4YLTqP9VrM84HlGkYZ1SeyBbOjon5kxF4cfAE9LHlLN8+5t00uqHw5I9WmB9jek0vXNcMrw7s9rNybs3dpdlGpnscfJf+82aMZZS7Tmma/6Lr5OiRgoaIJyJpbx67rsJUsp1qvxHwX8o6GPQzhM2uBVmkF/EduAotpwdUvqgvPs/ylDltsCAisHE4kHfVLLKrGrmloSqqES2IkGSsNIYE3AWU/FFQ+hiC/pTy3W+hmPprLTxQf4nReMBgqn6ZOURRUhO/eMb/9NU/9ztOOPXT0pLPx9MCuvt9nRNedFqhcEK54o0Q6zdmwTvPhUfdc90S373ohMl6IZ3ugR2f8g==
ARC-Authentication-Results: i=1;
DKIM-Signature: v=1; a=rsa-sha256; bh=XQJflwps/MuD7o/roO/TJX9kQzhs7ZSpG3554A
 8PasQ=; c=relaxed/relaxed; d=oxsus-vadesecure.net; h=from:reply-to:
 subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
 in-reply-to:references:list-id:list-help:list-unsubscribe:
 list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 q=dns/txt; s=dkim-202410-rsa2048; t=1736351339; x=1736956139; b=xGM+Wqs
 9LD1YGJEr5CJV27BMHasau/LXh/JupH16nPtgup/sM47sbEFKV8y1GPagUaGkGccy5EhSei
 E7+LSfONXHrU3cRoCxlei5ahlogSecbyUbfpnXDWuaBt8jOeQM/S7Y2mtobGPBcZuogYmyX
 tDfj7tk39i0zOIPlu1va+RYc0lPOU70HiAq2I8gz46/bInao6QP4icdwGcn8Vo+oj4gpBsY
 gWNEl2fsejsCdNyo0NAbxbcLltknK4l+/fZlMfgNLZddP+otg83bKzWq5x7Z6VzCKmy0WgF
 ND/y+S5eRdZPltlZIJFhdUosnpw2qQCejJgd9uAHUSGWvM78URg==
Received: from proxy-5.proxy.cloudus.ewr.xion.oxcs.net ([107.143.227.186])
 by oxsus2nmtao02p.internal.vadesecure.com with ngmta
 id 6141203c-1818c2579aa2d5b0; Wed, 08 Jan 2025 15:48:59 +0000
Message-ID: <9cefbc46-ffe6-4122-9743-c44f64a3cfc8@rttst.com>
Date: Wed, 8 Jan 2025 09:48:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 86_64 host is not supported by hypervisor - 2024
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <3fd90b0c-ff50-4dc7-921d-bdecb82c7777@rttst.com>
 <Z36SpfwBeajgIWYZ@redhat.com>
 <5ac40944-367f-4898-ab07-df6ee56644b1@rttst.com>
 <Z36YLpjUxsLd7Ly2@redhat.com>
Content-Language: en-US
From: Adam <adam@rttst.com>
In-Reply-To: <Z36YLpjUxsLd7Ly2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=15.204.3.6; envelope-from=adam@rttst.com;
 helo=nmtao202.oxsus-vadesecure.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: adam@rttst.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Will respond shortly.  Doing additional troubleshooting at the moment.

I copied in a backup from 02JAN24.  And, I tried to create a new XML for 
same with a different name vFRANK2 vs vFRANK.  Prior to creating it, I 
specified in the virt-manager to use host-passthrough for the cpu.  
However, upon creating the new XML based on the original .qcow2 file, it 
still changed the CPU back to qemu default instead of host-passthrough.

Regards,

A>AM


On 1/8/25 09:22, Daniel P. Berrangé wrote:
> On Wed, Jan 08, 2025 at 09:13:47AM -0600, Adam wrote:
>> I have backups of the xml and image, and they too report the same issue.
>>
>> <domain type='kvm'>
>>    <name>vFRANK</name>
>>    <uuid>88c29f0e-0d18-42f9-a198-bc9c679fdf8d</uuid>
>>    <metadata>
> What is reported for
>
>    virt-host-validate qemu
>    virsh capabilities --xpath //guest
>    virsh domcapabilities --virttype kvm --arch x86_64 --xpath //cpu/mode
>
>
> With regards,
> Daniel

