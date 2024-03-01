Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0355AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvto-0004w7-Q5; Fri, 01 Mar 2024 00:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfvtm-0004vw-Li
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:57:34 -0500
Received: from chameleon.oak.relay.mailchannels.net ([23.83.215.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfvtk-0000D0-8A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:57:34 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A837A7A0FDF
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 05:57:29 +0000 (UTC)
Received: from outbound2.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id DD1707A0DE0
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 05:57:28 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709272649; a=rsa-sha256;
 cv=pass;
 b=YoZOMIffImz4xe+4w+4MqpRRklFbiI+2skOJfi+RfecyUhydedfu9XCy+EjbB3KUUHlq/k
 192eUD0jgixdJIj/E7O+wmQXvlDDajc4rFiVd8gXtcIBDkEEdYSU7rbqGFM6L5O3oMqROM
 QTFyUY2doR+CGi3XG8mjV2vnqaxjbo7qy1+jHsU76DWXl/oeytFsFgln3x7nnYv/b7VY0q
 AyJphN2IjbbJ9z0TnmAFmUXUu7UcOfiUiWNkVa+kh2FKC26KYO6a4ifuSLeyxBx6FjXZZ/
 6gWX644MRwLaBqhKDqHhRZsPidtl7slwKwPuRPo7jHxv/SyRmeMDJXgWvNNi6g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709272649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=KV6gQQWZPmh4J29BsPXTsJMhb5tBA4WA3QQg/DH8XaE=;
 b=LcRI1SsKngfZr+okgevcfkVIeaCTihjmIcJUJE8qwZmKmIAFxXcCtHy3oF/t8F+WGtSxCg
 cnvC8vLNaKLZ8fzwLzwzsnhE5+MqiVfpSySwzmiC5LEjUQ2eqIkv7GH32/FNWlQ11IduZ2
 y3JTWugHJ1vTyhAllKqL4XTG4lwS5GA9Qyh+l62maKGUl79YOHvkofSLw79hYU3BeVXWGG
 /Hyrludq+lBLBDZhrQNWA/Q2EujlaC97KzPQ8sjkN7bNuvDByodR4Qy4wNG/vvCJY3yArp
 aBBU8/rhlSNIQYVOpZQFCK0RssD1Qkc6pb3aUZW5A96aAtaEFhHu+jQNltJg3Q==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-jg54f;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Slimy-Duck: 2dc1b57c5180f86a_1709272649390_702258032
X-MC-Loop-Signature: 1709272649390:3575172224
X-MC-Ingress-Time: 1709272649389
Received: from outbound2.eu.mailhop.org (outbound2.eu.mailhop.org
 [35.157.29.171]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.142.242 (trex/6.9.2); Fri, 01 Mar 2024 05:57:29 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709272555; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=b8fHYEbDrvcTkITnUz7a2siClAP529HcGpreJykljjO7/Q3lRULlAiITyFXIu0EAqy0KErHZr+Nek
 rXzj11fEdX1wVbGdgIsZdcPbG/r+CVwkjymoWvEhBgjCazaSqkwlXhBxwH1o/32s5hian42Dd/JOnS
 hQpoAZTJ8crD6f1swinZmruep7Yoly7uWf2zGdBm7pLs+zbzQk7sBhnzg8qYWifNg4on56uvch42fl
 eRhg2qX49+F+vFHuNha+JFIKZ7+x2U5kKW9yIjRx14nAaFKAqKyJSZOmSrD+GIkjhR6UunMa8shAHK
 E2zSloXrrS5eesRDWB19sNSoU6NRDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=KV6gQQWZPmh4J29BsPXTsJMhb5tBA4WA3QQg/DH8XaE=;
 b=osPvfj2z49wJR/RViLrqbNxXR4MPrTin+m1L4c+9hkw9+vyYmu6yalvTWiAWTqiA8mw5mS7qZFsKV
 SH6oJx58sdVVnm2lD6ssktNpJ1LThoCfdTTtorr2ZBCAJLctUY9cZxrFANnlMbIw2FijsEU7uuXsTz
 x6rWY8nVDXXgZY2ao+aFshOMzukDDQnIv/ip7YNnJu8gyQ/RzMXwwLSVJmV+aPDbm5mpz55Y6n6SnS
 erzf15RjCN6xyJTBH/iw5mgoJ7kWhCRaXjMJeJNk3g7GXNkVvB6YQzO5YBH/3C2BNg/+Szn3bUsnh0
 pOOVACbC7evPlQtm0V5Z9cKIoeJiqjw==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=KBhD8Vf3; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=KV6gQQWZPmh4J29BsPXTsJMhb5tBA4WA3QQg/DH8XaE=;
 b=aSJMH9l5VhiDr+jMkFeu+OQsJILPbMYGLQcU4lXAEzqNhq57ce9g4jRFRtTo0LD/ji1vqVK6kXkR1
 yN2C3lXw0lsMBLV7OEUP/S9Qpb5h/+5tBBZMEsTgPRsWW2RlsBQvhsdupF+xhYkjnrynMDPg6xk9gG
 NHYJUDGq1DCcZeoo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=KV6gQQWZPmh4J29BsPXTsJMhb5tBA4WA3QQg/DH8XaE=;
 b=UASTt3GTPnAYcNY6/XN2ZdWm9rjwjC9moofBRWFFEwAvrxKXSMaLFRi12766o11DwVdcqmHSaSoMS
 Jr99vgUDqg18PF0XlqAMCyWlHz0W4rj5EHypea1FaJ1MbH+OXsh6U+bIcQUi21jwty7sfPG3tuPhwA
 fTuOEKZUq5XgnU0dX7dMVu2JFOt5vHYMAOTZ3wlayTk3fLDEsGJPmP6jWtS59qJBFMCE98xi9xaBz7
 eks007hzMFMykRlLvsSU5LRq0/Za9iZ0XACdzu5e0A1s5VNIFlxm7CwzG4XkWuaXDFM+3jhF26qkol
 pobw3B+8S7ZzIfBRPgEXmg5RwsdkeOw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 5adcfc91-d790-11ee-b664-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 5adcfc91-d790-11ee-b664-9b9d9be6ef2c;
 Fri, 01 Mar 2024 05:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KV6gQQWZPmh4J29BsPXTsJMhb5tBA4WA3QQg/DH8XaE=; b=KBhD8Vf39vZx8YnXS/OEFrjmU2
 SDsz0aK0k7rSRIhiTwLRFYp3aOmxGFKfCHuAYZv0lKi0OhlOqBT+cylKDW22vfQN0sEE9G+Hy/Pj2
 t95KzuMlQZ7kZLmPIKMiLyWb/7ziqnOjo2XuFKXxA1Aae7CZk0b/zOXfVK+n9Zu6w08eg6wetiTys
 s4ezRSc6iD7fqoykjPMEq4AqYrkLV92bN7C8wWE/dDPsxKLLJQdU3F6Xz70CjVevbcNuFjlNwL3Sn
 TTarQMG8MhM2ZpWKoLpPRaxv4hylxIERf+h6Cj4Ftsg4/7M571oexwPx8TeFIKCJCh069qE7wR/DM
 4fSjh52w==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfvtW-000X31-2a;
 Fri, 01 Mar 2024 06:57:18 +0100
From: Sven Schnelle <svens@stackframe.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add timer to scripts processing
In-Reply-To: <f5fe5ee1-fd43-7cf8-73bc-d0eef4b5eb98@eik.bme.hu> (BALATON
 Zoltan's message of "Fri, 1 Mar 2024 00:01:24 +0100 (CET)")
References: <20240229193031.1677365-1-svens@stackframe.org>
 <3cec3ef8-557f-c481-c64c-9b8288b16a31@eik.bme.hu>
 <875xy7xbuz.fsf@t14.stackframe.org>
 <f5fe5ee1-fd43-7cf8-73bc-d0eef4b5eb98@eik.bme.hu>
Date: Fri, 01 Mar 2024 06:57:17 +0100
Message-ID: <871q8uxznm.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.215.33; envelope-from=svens@stackframe.org;
 helo=chameleon.oak.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 29 Feb 2024, Sven Schnelle wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> Yes, i changed it to describe the new method:
>>
>>    /*
>>     * Some windows drivers make the device spin waiting for a memory location
>>     * to change. If we have executed more than LSI_MAX_INSN instructions then
>>     * assume this is the case and start a timer. Until the timer fires, the
>>     * host CPU has a chance to run and change the memory location.
>
> Is that the host or guest CPU? I thought the guest vcpu needs to get a
> chance to do something about this but maybe I did not get the problem
> at all.

Of course it's the guest CPU. I'll wait for other review comments and
fix it in the next version.

Thanks!
Sven

