Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A405C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xv-0005IM-Qh; Fri, 01 Mar 2024 12:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xu-0005I4-PU
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:34 -0500
Received: from snake.cherry.relay.mailchannels.net ([23.83.223.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xr-0000Xd-GN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:34 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id F05927A3C2B
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:24 +0000 (UTC)
Received: from outbound5i.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 333CA7A3C74
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:24 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315184; a=rsa-sha256;
 cv=pass;
 b=iilmGVYdethiCt0d+G4hVqrlB+aHZVEi0h7sM+iusDoS6ADmkeMssrnOhkRHIu2aiEtDmt
 wnF6tctsLqp8iKswDprTT213e3TK27hB3mAP1AnoGbpohZD+fk5L1EmCs9h7f/zVv0nAg5
 I+WRtB05bK4xD2mIDE8tumGeHVGq7dBdv8G/X00ZCiMoIuwztULz1tVQ27Lq03mxEeGe+I
 2OTWTUoVNkk5MAor7DIPyrBljgMlhDj6xnr8NhVkqfCu8R6FX7WL/c5o0BuK4AnhEvLvD4
 Id4DAeuFQa4Sz9m7gozLD1to0gCGZkJgizxD6czQFijvdSJBWwfcjmkGthLpEg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=mwYJMCU7D88UX/GbpooanmeUt8VSm5DbhN6Hu9JLxek=;
 b=oB+0QwWTSqTw/1dhDmknWt7784E/0HFb9S9bj3qhHKRVchiqmCX8uQkFHjrnh/PgMzL9Ph
 /7eThf1RD1zvaaMTClEvdiOOk5rySUSKM1b3VmfPJx8Dg9QNgUKt7zL5TXkVPd/1TAFflT
 WtpD1NGIEpWMgc/BPsEid7ISuLkQq/j5TnAHM9zerLEy2HyjQ+T5iz4CucKO5hHUVb467i
 W7tWDE+KaqLXNEh2K/Y/P9VUmxeGjcDmkY4p/W7kdJ1PJYF4Ugf2L2fYhIDwCeIooNfvb6
 WMdXob4/C2dVoC0toIXCwO1/MXjA2U4PsIj4PyodbcIH0AAFeoA+KsRF8khj/A==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-2hzk2;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Cold-Slimy: 06d85f46667be76d_1709315184699_2942133242
X-MC-Loop-Signature: 1709315184699:3827590743
X-MC-Ingress-Time: 1709315184699
Received: from outbound5i.eu.mailhop.org (outbound5i.eu.mailhop.org
 [35.156.234.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.27.58 (trex/6.9.2); Fri, 01 Mar 2024 17:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315093; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=FvbOZCxqlSkZmo25onXSwc0qAEP89hggzmrCdikLygzEpvKWFPf4kbcZlXf7pSAjdndKFD+QtdkL2
 QrtOx/l3N/lYr0mo897hRv4JLXWErPNIUtqvCx1AqhvJrBML03nV5Dlq326O2bfZzsqVD+M6Ys2vTD
 aWOwtLE0oWOkT0VjlcVYgo0o0tl8BxU3CKCPhVudctPlfGVl3j7pG9ibgPErdjkI7ARxotWaHTD3jO
 31JZA0WvC5pRKpP/PVOPG/diwQaGxZ7QVWh07x4MHbN2wvznFogkLWMJgWxqy8HMPiBa/0ZdtpjwXu
 IFZo1mIpJ59xUhQwdfYKGQ+88ec9Tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=mwYJMCU7D88UX/GbpooanmeUt8VSm5DbhN6Hu9JLxek=;
 b=T0nS7xTT1POexmUO2CjjvLtKW6eyW5+HbTw6AFYyKLwbUGq8y5ebEM6fWzgokaJHF1xoavxW38tWf
 26t/OWFrXBOmDj1f0OAmkG/WEjfZH9TCQMfg3B1iUVaW5otjOjTGbnVVfhNDCikC1FNvpcCzQK+mRJ
 xt82KTpyboRyZGaSOz2P6LzIA3EjATJ/dUI63Bm/2DC7GgUBRQO5alNPlQZGyvjmp/PSWbssju/pp3
 m04PVDDjPbH75nMkDmsrOZPQKlv6ki0i/PKfdJ0oJIjh++kLvXbTdj+npI73AtgREUjXnja5S4ukoV
 NyC9ziNNkf2vWy0AbKgQKePFp4xRZVA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=a7XSzUWE; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=mwYJMCU7D88UX/GbpooanmeUt8VSm5DbhN6Hu9JLxek=;
 b=jyizQDNIP6UI6wdRrX0/XhTF8W69CYv6PyguVyzXQ+yJY3lbc6Jhy1Nzk486C+mUjglPMJdMjA7aU
 RxG/R9UJg79YVTrZaawCy/RUOXqCgC7r6F2KqF9QiJFVDoisadgJ/k7adDRd/AcGugBYUAdbLf/2VL
 BtdnwgWdcoWnJTrQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=mwYJMCU7D88UX/GbpooanmeUt8VSm5DbhN6Hu9JLxek=;
 b=L3TXcdd39i79eTf4oHTmyZYgEL9A18TLLJyRMS/YAp+47ytnyrmKzKH/MaNUlnBYNyaCpCUXaZaFL
 mSJzfbiecOPUdZr/KUEecIQ9esCRKHkhFEJY5Br/QjaHPgVoMMwzC/T0ui9lyljzhsiiErhautQ8+4
 BVAnfDUZ4n5egdIrsxhbVTYE/VXK1pVg/MinzskV1F/oEy7lgvPFyd+CDN4xnrnKXdsDsw/L5udQpl
 yjuybSlOvSTjYKFZJWVUwn4KXxjxvezNRvwC1DwmUvoT417+bZcwjJ5lCLo2mwRNr1Xr8g+q9owEde
 oEsqAl5NEjO0nZRw44JlzfAnDo1Lt0Q==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 65c00af5-d7f3-11ee-b66d-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 65c00af5-d7f3-11ee-b66d-9b9d9be6ef2c;
 Fri, 01 Mar 2024 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mwYJMCU7D88UX/GbpooanmeUt8VSm5DbhN6Hu9JLxek=; b=a7XSzUWErawCAzre024y6zuwWy
 NEM37zp7cI2eZU7bVyJlIBdnOL0ah8ZjqcYex3BFZTVZrlTS1zRhKllOS1mPp526JvV3jJgP7SmG+
 mgFTkKPTqdXm3V0/JxlQQhw8Kt3bKLLck822ngzNF+N/UkDEjidU2fb1DVWBZf+qStjQmYG297Ekn
 pKNocmzUecsre+e99ZCsLb3hGqKxo2vhp+SMNjU+Su6SGGuua96tacv5N8A9BHYAJjAlh/c9soQQs
 0eZ+yflRwsUgUN4vOtO5oaRelGk/pi+u+bXzLXUjgnq5oiQa6RUmGAdf+cd+cyaxFpzivANnDxIzT
 O8vhM5+g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xd-000bs2-1x;
 Fri, 01 Mar 2024 18:46:17 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 00/12] plugins/execlog: add data address match and address
 range support
Date: Fri,  1 Mar 2024 18:45:57 +0100
Message-ID: <20240301174609.1964379-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.171; envelope-from=svens@stackframe.org;
 helo=snake.cherry.relay.mailchannels.net
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

Changes in v3:
- extend plugin api to re-use the existing range parsing infrastructure
- export error report api

Changes in v2:
- rebased on top of latest master

Sven Schnelle (12):
  util/log: convert debug_regions to GList
  util/log: make qemu_set_dfilter_ranges() take a GList
  util/range: move range_list_from_string() to range.c
  util/range: add range_list_free()
  util/range: use append_new_range() in range_list_from_string()
  util/range: split up range_list_from_string()
  util/range: make range_list_from_string() accept a single number
  qemu/range: add range_list_contains() function
  plugins: add API to print errors
  plugins: add range list API
  plugins/execlog: use range list api
  plugins/execlog: add data address match

 contrib/plugins/execlog.c    |  55 +++++++++++--------
 include/qemu/qemu-plugin.h   |  53 ++++++++++++++++++
 include/qemu/range.h         |  24 +++++++++
 plugins/api.c                |  25 +++++++++
 plugins/qemu-plugins.symbols |   4 ++
 util/log.c                   |  84 ++---------------------------
 util/range.c                 | 102 +++++++++++++++++++++++++++++++++++
 7 files changed, 244 insertions(+), 103 deletions(-)

--
2.43.2

