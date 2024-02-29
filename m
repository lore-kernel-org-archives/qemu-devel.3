Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17C0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi2X-0004Rr-2V; Thu, 29 Feb 2024 10:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi2V-0004RP-1w
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:09:39 -0500
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi2S-0008Kx-H3
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:09:38 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E58197A358E
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:09:32 +0000 (UTC)
Received: from outbound5e.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 035B47A3377
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:09:31 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709219372; a=rsa-sha256;
 cv=pass;
 b=pHehqE7G8Z1kLItSAS40Jlx+ZGywv2F3CHoSTqXV00EkrpkVyVaRP2ofV54tySB+klwqjF
 B3Uc/UcbAh4m1RXCf5ITt9ia5gNzPZczaJOenaOlVsyI7onfI9jqQYyaVz7MvcjtCa84po
 aIpr97+aWrGTsPj+2OATqyTe/WVrzpmuOyQXasj/gm1IxMSv1KyqI7JBSuexrH2vP2uetk
 esKfTjGL9PJhcV0n+lfvBr/KOSwfFl1t9Fc9nWhbUgiPvp9LMYVrl/jNiHN5WF/1/I96h1
 rYanLMgfu/w1x7Kf8TeN230t8mvcVYQZQdsa/J5EIcU1Rw0VsjuwerRfE0tmgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709219372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=jRKnle28Yj6zJCF6we0AnhgRYCrX6sO8F31owM9uZAg=;
 b=NcLI9ijJSgj8Rcc5PVxOI+hWU1J7Aw02VKCSa5KU8QY1JmC5mK/knXcDIYJ6Dphl6bC35r
 j3Epiu2lC0BfUQ5ETfawzK0lngMIr86MtSY2brVQE6DvJwOf5c2DtpThnzu18VuZUEMZJV
 aO2dGuaasE0YXQAf8ynVDM+KsYwRC6RQbtroYb2DJh3UCKLhtzAgsDHkPbgEM27YoF6dKj
 16vDdtNd/vleS7f5NEb/Q5GDBV7l3uTWE8b5D6OtqJOuCl/sF60YveQLx+OGNevoan/+l+
 XkXtyoe/lR7YNgIkK1pKaDttTGBpa/rT2MKAWLhL8ne72ika+Wk3NlDU6Zt1FQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-7ddvb;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Eyes-Shade: 3c5da0de1122a070_1709219372737_3401609789
X-MC-Loop-Signature: 1709219372737:4266106656
X-MC-Ingress-Time: 1709219372737
Received: from outbound5e.eu.mailhop.org (outbound5e.eu.mailhop.org
 [52.28.168.19]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.142.242 (trex/6.9.2); Thu, 29 Feb 2024 15:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709219282; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=JnlEgnwXiUJSqLe/fGZSO77c0CvHQKQbdojW5wFr6x8q53p637QRZckMrmXUDeGKs79mA/Ut8oWIA
 kOamNZkal9ltD/ttXSn2bp4MF6Ar5Lia8hhqkpddbeFW3804pNzOTZjPeFBljzIlmekEFgk6iK+F5b
 cK/t9qj6VmvRNgyeFofDns880ZgJfswbDDAL+WHafvXxGYlxIVV7kwHGaxXHJgk3DQOJya2wXv0rbv
 s/xS0QZW+ToRJbhQ/BHMi+s6vPaoiWlPUgehp1etq3GqxaSQHGuNGtnHvRlqyP/nkR0lBeruB7sldY
 7qWAUlHzbBIRnjQNcDRrIibw5u95RLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=jRKnle28Yj6zJCF6we0AnhgRYCrX6sO8F31owM9uZAg=;
 b=h88rnZXizO+TnhjvBfERFY5ByG+3+Rxnc2FmdpSOMlnFD02ci4B7C/SwO/rM78h8dBlhoz1BQKTu4
 jRmwsSyOxA6rvQEbYMcBTiRHLYX7Wl3f07nCbLB4Uk9yjgQZR8vFiyX2Ovq9ZwU4ts/Avtg6NFdyLS
 CwCRdAHfxfrGy5NnoV8njrV/Ope/DGPdywZsKRnS7dbNzhqTSEytJjUm7IS+jGeBE5Tz9uCohOCUH1
 +lPFhHgxsoWxGQ8p7KUv4PFR1MfZcdhp7FUJC+SLALHEcAxNl5GE+0JZBZWW5qGGwuCI7Io2wSaeqv
 VX1SmOGi0JQq/lnrlfVkR1hbqo2GsIw==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=JVznNBs/; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=jRKnle28Yj6zJCF6we0AnhgRYCrX6sO8F31owM9uZAg=;
 b=mYRQVUlWnQY4PF4BEtMK+B1zo+NzI79G+U4+w8fkhhKvd1UAWQuGY0fhA3aklCzR0q285e5my+y8V
 xsYebMUewWNp9evXaaA+T0yK4iCrxp6e6EK3ouG38Ij6gwkWvLDYJf5rPwrub+iT9RqUfCL5H3phEP
 6S01QSU92nUAF0D4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=jRKnle28Yj6zJCF6we0AnhgRYCrX6sO8F31owM9uZAg=;
 b=Qd+3zFhtGnhbqhZ3jz8qZMmPFdlI9pi6HX24m17pdAseZgKlXqrXUzblAz2IHijH3AdB4AKmZzpsI
 l+IkM4PUAregTwe4ONNE5ReEoYfaeAakR6SKxxpV/R9ivnNSm8bdGBSpKLY7Bhz+l93nh8Z4//kv5O
 hvtdVimHOA1azLD0G4taiIayx1HahqPBIZuMQSeQhcFXkFRZJaKcH3Q8elpYke06rKk4UOCC4GPG4F
 585Xs6+n0U/cTg4vmaRA6Am0LvxU9oRgy5WlVuj9Ln+tzA00hx+Fz4Jj0Wyp5HqQwfLUxUa+JT3o61
 drrMY/vPv0cWGYti+KuQFpZINenXCWQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 515bc54e-d714-11ee-b65c-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 515bc54e-d714-11ee-b65c-9b9d9be6ef2c;
 Thu, 29 Feb 2024 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jRKnle28Yj6zJCF6we0AnhgRYCrX6sO8F31owM9uZAg=; b=JVznNBs/i5xXwOsiGfoznMlaSZ
 fRiHmRrOIH0UezDwrZavUxNK/natdWdwLYM7Z74pt8s5DWRHJfecYJzWhfae3lLGNwHT5GK7YeroP
 S7lnHUGHAdZADIhggGBX+/nyj9RnbQtVXipj7Eu0dl3DV58y9UXeZ75zuyBZEs6dn7Zu06oI2HOZ1
 UfWAOoYSfGZelc94ZkE09okYEjgNiaUXO8fwI5WdcBoJcd8FnDzizc7ry6zX/cl4I/ODcGm47a4vx
 eRzOURZILrSymSoXmyEOiSR63B89Z+NcFV2JZqYFZNg4KIghaFo0tFyrNNd1KDdsQUnhU1TS8fz0v
 hsG8reIg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfi2G-000LkB-1j;
 Thu, 29 Feb 2024 16:09:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH 0/4] plugins/execlog: add data address match and address
 range support
In-Reply-To: <8b87d401-833f-42eb-b06d-839bcdbb50b4@linaro.org> (Pierrick
 Bouvier's message of "Thu, 29 Feb 2024 10:05:32 +0400")
References: <20240228200211.1512816-1-svens@stackframe.org>
 <8b87d401-833f-42eb-b06d-839bcdbb50b4@linaro.org>
Date: Thu, 29 Feb 2024 16:09:23 +0100
Message-ID: <87v867xq70.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Sven, thanks for your series.
>
> Yesterday, series for new API to access registers from plugins was
> merged. As part of it, execlog plugin was extended to support this
> [1].
> This conflict with the changes presented here.
>
> Could you please rebase this series on top of master?

I sent out a rebased version. Should have done a git pull before...

Thanks,
Sven

