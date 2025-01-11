Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AA6E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 15:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWd5O-0001T3-W7; Sat, 11 Jan 2025 10:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@chandra.net>) id 1tWd5L-0001SS-88
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:07:35 -0500
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@chandra.net>) id 1tWd5I-0001D8-EH
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:07:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1736608046; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b1jFhh3qLBzhXQ1PZgxb+N9RoORT31Jk2LG20WxuT5B6mqvVtIloWjbEPLn400WyaHfoury7C7nX6PDhYQDkVamvqS4KMVyE5BJHZcLghAQYjKryJayP3qKHjq+xm5Ykqtd07JvgY6kqtVSVvwYDH90inJXpwrWj/iWeRhBd3oc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736608046;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=jA6LqzxkqEXVE7iD0DuhekHEi3vE5l+KIObB1IuK1PY=; 
 b=Xc+WHRcAnBZW2n2JEPNGJcgFYLk2YV/2Cfui8IaJl+DUttUn65MIXFsOLVkFAWtYwAgX7G7UHhSGY6qCLig99T9kpn3tmsYj1CYzvYYQi9ljHtmJOoyAV4zEC8/0funmXJFayR1hRr9JD6tDZhygWdOI++4nXLggijx6HkAfHK8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=chandra.net;
 spf=pass  smtp.mailfrom=rahul@chandra.net;
 dmarc=pass header.from=<rahul@chandra.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736608046; 
 s=zmail; d=chandra.net; i=rahul@chandra.net;
 h=From:From:To:To:MIME-Version:Date:Date:Subject:Subject:Message-ID:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=jA6LqzxkqEXVE7iD0DuhekHEi3vE5l+KIObB1IuK1PY=;
 b=Rzbf6GQ/Fx9pQQO9Hr2j/O0XukZa9svnhO0lNH/xBMdwuPBaGhiuLafWgBGGryte
 Wl3HfkluIxAOSS769WlOwBj3xfoU6V0kMolYcTsi4kSEN3Xgy73IIj23MpEO+ouAgc6
 V7O9IANRvvOQiRfMVSmH900W4x/RZ1qgRN6aUUlE=
Received: by mx.zohomail.com with SMTPS id 1736608044402353.3992764766058;
 Sat, 11 Jan 2025 07:07:24 -0800 (PST)
Received: from sogo (pool-108-5-102-140.nwrknj.fios.verizon.net
 [108.5.102.140])
 by mailserver.projecteclipse.org (Postfix) with ESMTPSA id B4F29E7820
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chandra.net;
 s=default; t=1736608042;
 bh=jA6LqzxkqEXVE7iD0DuhekHEi3vE5l+KIObB1IuK1PY=;
 h=From:To:Date:Subject:From;
 b=iNDq/rn7S0K43iVyPXTvYAS7O23b1NCJRC4cA3VEBSro0pDqeZL/detczsjdwoJ4U
 avuHRge3Rbdow699JbVfQZDB6FC3deXSH0SVlBAYP9SFxXX1hoKl7xElV/qAn2p3cb
 //lkcrR1bZvDvZyp577hFJtQzoc88SkPKbwGinkddBzRft5rwhW8hCUfTM39UeqOsD
 89v11BGyUklJ5SIEh8G8h93Bk4UpOwJ2DSlkHOE0fsTBheGJ5dekVcsHYper5fGXoP
 tpMtD+Mk/rPhgmisG8+m0goNFcC0CnjaXbrirZ6CINbd1qUyxYHFe19UZRTAJsgkB7
 OZ6MzhwzfwI7w==
From: "Rahul Chandra" <rahul@chandra.net>
To: qemu-devel@nongnu.org
User-Agent: SOGoMail 5.11.0
MIME-Version: 1.0
Date: Sat, 11 Jan 2025 10:07:22 -0500
Subject: =?utf-8?q?download=2Eqemu=2Eorg?= file list
Message-ID: <1fa-67828900-3-616bbe80@197637592>
X-Forward: 192.168.1.147
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54; envelope-from=rahul@chandra.net;
 helo=sender4-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

I am not sure if this is the right list to send this to, but the https:=
//download.qemu.org/ download server is showing no files available for =
listing. Is this unintentional? Or should I be querying the Gitlab tags=
 from now on for version info?

Thanks,
--Rahul


