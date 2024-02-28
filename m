Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C8FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQ8r-0003iP-Rx; Wed, 28 Feb 2024 15:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8p-0003hK-Qv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:59 -0500
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8j-0008GJ-El
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:58 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 8A9752C2978
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:48 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4303E2C2608
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:47 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709150567; a=rsa-sha256;
 cv=pass;
 b=uJgM+J3Qlqprsj0UuNQ7jqu+H5aRJtvflFIXjgacM9Jaqb4bbqJIRJH8bEtQb2omQCpWXA
 scS/MRvXp0HpHisqg0+MJgdnSHf2CT9sH9Brv09d2Yn2tlmzlIJm+yPoUW6fZZdqLBDf7T
 Y92K8cHQvdrPplRXJOF1/xehIFU1atFbTlpq4TTOE0OXOnwLNc1FhkSXcLpQMVtkpD8gEr
 OxCC5HaQleUdLvrZ8LRiO7V+Wc3SqiLtM/RBlrBikMXLKnLtxNwMLMdYGZLRXHcdYl0iqh
 2Y9WYqud4X/1XFnoTq0lYJQl490xn9ZJq2gYSBi+Vkq9QJBUrths7IMmf3JZcA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709150567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=mkE+WKXeb8kvSrucAcxM1ZdzXdhVyVDaYewAj62Dd1g=;
 b=BgwCEmo+yig1fseyC3rYkl1U8F9cKywVucXWeZ3kTB2eNSzNFRe2B3UQD/QIlav/gSadGf
 bL20hm/Upg9wQ2pgZ0dXWFhvldKDsqytWsTuQN0JXBAhGi0Z91XKsN9TF8rO2LS0mrQxoa
 6hTozSjMOgrS0WNPnBawk/JIL14vzyKnCvvK5IWSIeGgTOgyfwbI+zMg89ShVLX8eE1Z42
 JbLXkvwm3qb+KPhyPZ/dKDa+SlRpJwEDm5mvoOIKLb8eeDntuofZmA/OYty8w1ax2vNlq2
 ORYnx7HO0/oIAe1QH4emAZDbmVd/GQtmwntuVoGqGFJcjRScWZgnou5Rgjku0A==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-zdc5v;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Sponge-Whimsical: 7a3b7a825a63ac69_1709150567770_2355675814
X-MC-Loop-Signature: 1709150567770:356915727
X-MC-Ingress-Time: 1709150567770
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.142.242 (trex/6.9.2); Wed, 28 Feb 2024 20:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709150542; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=TSPpWbpjRP5akXkDkVMfPHuKML65EQtwswZUwniAfcJo/6H+FpSyK51pPNJnFSZ/cn++LKf1tiCvs
 cCrgPbLdkTuAEAZ+xjmKH6d0eNVnxG3OaIV3CNfZHh1NZGodq5jPOelu8OfnDzRleVvhgqIdiN4HNV
 8FPTcbSIhUowYyugcR44WNorTdV6a9Oj/U1bmcC3mIeHYfwn4nEZhdpbs4lEgZmQ+bXydXX0D6Fv9S
 4I3JAp+0QHVvgnflOMV9LYiOpC5OcxPb9pUJGpE70q7Cp3vcO/7TjOe3olkV4Kxvex6RFR4AtqQRRJ
 ShkYbXba0tV0C/8T6tB3tIWE6xOiv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=mkE+WKXeb8kvSrucAcxM1ZdzXdhVyVDaYewAj62Dd1g=;
 b=fepwXBp81w2+S5VvKyALTKiPOrXVsoK/FnMQ3kRshFGY1Uss6qcBLrtNh77MAyJLjJnwMBqq7j5Pb
 QZuI22Qy/b9/nrGb1z6fJf5QDJvhbhwhntnsnBw2ydU5FlXrXg/qphfK4Sb5KhDs77lbeNzaI1YcjY
 4594g+k1nGin4LOXfeg1e4zMTCdARGkIwDFdSsA+fZr5lqVlf1DTdSdhG1HB/I0pqlkxJ3I5Y7eCFV
 p1TwyiWbeipqxVScbFW5Lgmv6+qKUAbh07xDVzuahXpTuk++TJTUqzkEt6pVL/3eVz1QKHL35l9Ns7
 wI3httW61ZkIFMYWzCnNncJl28WQ0nQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=h8z+gJPB; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=mkE+WKXeb8kvSrucAcxM1ZdzXdhVyVDaYewAj62Dd1g=;
 b=V6bKtZ9mNbv7qU5+PoFkvDoCbM+uZK+B6bzX6zS1BMoe7CCHYb6vFxgh1rFgj0L1XLAgW+F/e0wZ8
 WfYlX2Xnc3KDt2PC/B7xwtE3gdPxBg4YbIcURyF6B+rO5oVYABumBA+P25b79j2ynL8TlFLOmTPvnx
 W+atPy0KYADExso8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=mkE+WKXeb8kvSrucAcxM1ZdzXdhVyVDaYewAj62Dd1g=;
 b=BF97cjfebExwBOvkQan3fURCHqZpNHBkIyPNY6HaZpiL8Tdef+yVBA2tiHsVDFuH/fqmhXISzYFQ/
 Rd0kMMnfLaf72bLkbYUjdHDh7gPYY95Fcz8tLqC5qGTge1SEgIwGFV3cySBJQZH4Z1Hj6fLqkMbptS
 qG6SxWdi1MkP/arP+7X2DDUiEH5FzCPkbXwoqmXKpglIkcbYjXsrHlQ3rDJXtteE8IBowtzbQfWyK9
 Wy0muIru/uz38eEQTNeazbI/ln9Xc9UFDrsyGFr1CxbJGk+QQxnPDKLwKFU9JH8KUa9IUAAKQwuEIA
 KWGK2TTShWxSou/KXqafkjbkI8HigTg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 45e64da0-d674-11ee-af93-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 45e64da0-d674-11ee-af93-eda7e384987e;
 Wed, 28 Feb 2024 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mkE+WKXeb8kvSrucAcxM1ZdzXdhVyVDaYewAj62Dd1g=; b=h8z+gJPB/qwaNTReFASdh2P8jX
 3pXyGyc+X6zkxKPp9kktzNwgYnKg99j8GDDSlaVjwnAz36vIQTdovR0qSKgJbBMLimHTfvZYKicVC
 In6nKznOldXvBL0LMAyfQQbnKEeGzbGPyxc8HkCK6VNbRymgVV7USUbfS1lGQeTrC1ku3UDR6jYfD
 CblLinedYAlfRZJDg747WpoIQkEDRd1qYgb3jhNuwvA3yU5mJ9MZG3npfzrwn+rA+kMP+dRCULIq+
 Y2juRbnXVOrWl5Cb9uk2emIovjlknwt9w6fFJ6bulKPn+L1d4mJ6SR01ksWaJOrh+uT+qEYxVQLU7
 Kc1lrT5A==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQ8W-000DfK-2A;
 Wed, 28 Feb 2024 21:02:40 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/4] plugins/execlog: add data address match and address range
 support
Date: Wed, 28 Feb 2024 21:02:07 +0100
Message-ID: <20240228200211.1512816-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi List,

this patchset adds a new -dfilter option and address range matching. With this
execlog can match only a certain range of address for both instruction and
data adresses.

Example usage:

qemu-system-xxx <other options> -d plugin -plugin libexeclog.so,afilter=0x1000-0x2000,dfilter=0x388

This would only log instruction in the address range 0x1000 to 0x2000
and accessing data at address 0x388.

Sven Schnelle (4):
  plugins/execlog: add struct execlog_ctx
  plugins/execlog: pass matches array to parse_vaddr_match
  plugins/execlog: add data address match
  plugins/execlog: add address range matching

 contrib/plugins/execlog.c | 102 ++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 20 deletions(-)

-- 
2.43.2


