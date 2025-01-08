Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D06E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXkr-0003Wv-EE; Wed, 08 Jan 2025 10:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adam@rttst.com>) id 1tVXkp-0003Wk-Lk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:13:55 -0500
Received: from mta-231a.oxsus-vadesecure.net ([15.204.3.4]
 helo=nmtao201.oxsus-vadesecure.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adam@rttst.com>) id 1tVXkn-0000nZ-DU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:13:55 -0500
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=3@204339 smtp.mailfrom=adam@rttst.com;
ARC-Seal: i=1; a=rsa-sha256; d=oxsus-vadesecure.net; s=arc-202309-rsa2048;
 t=1736349230; cv=none;
 b=RUNRaK2SNhOdxmm63ZQhYpN3OJ0DvOrG5O0ZWtzqwIyEsYRzKuvAI3Cqc4csiINZ/6U7gfLeZoKv0aA4kHZmbhNXd91DQjfAxRMx5YIxTvUi+dLsaPU0QfPpu6yw8uOdoQbsRRswqiQFaI+1UDKr6sFGUZU8mhT4R+LH/x9BpU5vfIhZxlFD4Ai/jwH5X5tcZ7dOgTePfaMPonTorclnl+s13H+TaOmWCf5GAFFCkgItTUe0x7LiwYvH5qnvhVYQbloH+0LLdDIdVedBPF7Y58JKV9ordfgCRQl1MYLGKuwHOfPq9gPm4f6VgRGGzGqirYKHh45RYQZegFMJjfKsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=oxsus-vadesecure.net;
 s=arc-202309-rsa2048; t=1736349230; c=relaxed/relaxed;
 h=from:reply-to:subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 bh=8PKDm6jwaUJ1dI9Mc0QDveGADGB329tt4qR7MucSmZ0=;
 b=ICNfYbQjMZfvIynmWscpMhER/zymU2ddL90sSR8gid5eZj17Cm26EPLwFKt9LAqSBSyAyWSuUjCo5a5QX03mDEuUFHx87G/SYAQ+qL7WbAlLDUmKf5ff14auzjB+L/EBXOyc+vr0HPhqXMnfutN0ximYdZYBXD4lt+P4en1KXia5v068PosqqFELV3K/K12hgOwWhHC1Z7Ni1yVDHgVxnpKPweUO/Buxn9h3gJOZdOV0hJcJ/JGveCyXWbtuNCpXpxBE0f2DShz6jmf4vyh9N4783P9DBg6dLzRy2izc+kGy7GrTGaT9UaeBB786Y7D/VdNW1KiiZsd5PZ4gEZ1zdw==
ARC-Authentication-Results: i=1;
DKIM-Signature: v=1; a=rsa-sha256; bh=8PKDm6jwaUJ1dI9Mc0QDveGADGB329tt4qR7Mu
 cSmZ0=; c=relaxed/relaxed; d=oxsus-vadesecure.net; h=from:reply-to:
 subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
 in-reply-to:references:list-id:list-help:list-unsubscribe:
 list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 q=dns/txt; s=dkim-202410-rsa2048; t=1736349230; x=1736954030; b=EirTgbn
 XZLK164kaXWwMLkFKJIwe95fHCd1jz44B5YM4J+td4jOfjYk+v+Hak8hpBljZJNwbFRIzW9
 Kn7qjTuKgji47kCYltwjhwUJqic5m8fEWq0ZO+N0Exk7Xm6plLOi9iIOCgitzIbV3HsA1kG
 tMZMfD6UE+jY824f1H2zV+0tEoY+D+YFt/Cu+X2OHv0bGJpnKYXTIPMGpj20X1AY9dSGEfx
 NP0knsHV0cKbg7g6CL+qdu3In5zoDnw4MSLo3QraMNMmdLNxsWQelekTvlhTNq5XQuOM01Q
 5G66m0LAgVPk+s3USgDkpiBg2DVRMmeH90dkRyU18ufZ3KRYIkg==
Received: from proxy-13.proxy.cloudus.ewr.xion.oxcs.net ([107.143.227.186])
 by oxsus2nmtao01p.internal.vadesecure.com with ngmta
 id 80fb5067-1818c06c979cfb86; Wed, 08 Jan 2025 15:13:49 +0000
Message-ID: <5ac40944-367f-4898-ab07-df6ee56644b1@rttst.com>
Date: Wed, 8 Jan 2025 09:13:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 86_64 host is not supported by hypervisor - 2024
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <3fd90b0c-ff50-4dc7-921d-bdecb82c7777@rttst.com>
 <Z36SpfwBeajgIWYZ@redhat.com>
Content-Language: en-US
From: Adam <adam@rttst.com>
In-Reply-To: <Z36SpfwBeajgIWYZ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=15.204.3.4; envelope-from=adam@rttst.com;
 helo=nmtao201.oxsus-vadesecure.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: adam@rttst.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I have backups of the xml and image, and they too report the same issue.

<domain type='kvm'>
   <name>vFRANK</name>
   <uuid>88c29f0e-0d18-42f9-a198-bc9c679fdf8d</uuid>
   <metadata>

On 1/8/25 08:58, Daniel P. Berrangé wrote:
> On Wed, Jan 08, 2025 at 08:51:52AM -0600, Adam wrote:
>> TWIMC:
>>
>> Had an issue with VM networking that turned out to be the host. In the
>> process of troubleshooting, I
>>
>>      sudo apt reinstall libvirt   (and other QEMU/KVM virtualization
>> dependencies)
>>
>> Now I am getting this particular error when trying to use the
>> host-passthrough for the CPU.
>>
>> "error: unsupported configuration: CPU mode 'host-passthrough' for x86_64
>> qemu domain on x86_64 host is not supported by hypervisor"
>>
>> This was working previously.  I found that two other domains are responding
>> the same.
>>
>> The configuration in xml file is:
>>
>>      <metadata>
> You've omitted the part of the config that shows whether the
> guest is configured for 'tcg' or 'kvm'. Given your error
> message my guess is that you've got a 'tcg' based guest,
> for which '-cpu host' is not available.
>
> With regards,
> Daniel

