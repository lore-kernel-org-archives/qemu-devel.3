Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76FEC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52eJ-0006QY-UQ; Fri, 11 Sep 2026 10:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1x52e9-00065r-S6; Fri, 11 Sep 2026 10:54:38 -0400
Received: from nx203.node02.secure-mailgate.com ([192.162.87.203])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1x52e6-0003q5-Kw; Fri, 11 Sep 2026 10:54:32 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1x52dz-007lXR-Cx; Fri, 11 Sep 2026 16:54:24 +0200
Received: from Zeuss.fritz.box (p549f1c9e.dip0.t-ipconnect.de [84.159.28.158])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id A6A2A280336;
 Fri, 11 Sep 2026 16:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1789138463;
 bh=tBH0wlfAYpP6myz92dEV8cNI9wN1lct04SLfeH1CVbg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dq8PV9bDhrQ/SJH68b63TbblUJdHP38hlOloNPsk2PozgZOih50GpFC4TVoKUT/tB
 uknk1RS9BpA/jdHc+HE2nv28daEN0+BkRALBNW9EjexrbXIcqhD2s+Bhn9evVdwJWV
 ysmMWefhPpmfjfuT29d0Nss2BnW1scEt3vePsWl4=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/block/fdc: account for read and write requests
Date: Fri, 11 Sep 2026 16:53:01 +0200
Message-ID: <20260911145309.47164-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824114216.231916-1-christian@quante.one>
References: <20260824114216.231916-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178913843633.1824115.9842061255859595505@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.19)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXgvh1Ip62OfMNXnc7aw2tptBDkOaFz51Iw
 i1dQnvjjRyu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4ZYIms2ugm2A+tfSP93IKNzS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROCQUK4h1XJpMokC2wA6gjadOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEG9vh2CZ3C
 vkagHub+zVCHrxrAiQ9LrFKjKskiGXdOYidSx60qOlSfAsFXHIT+f9iB8EoVG9/3Z8UcmvWRxLLu
 Bqp2buWYGcRodxdIVEW2AixoUHGIFFY3hj94I7h01JLP/xcalTNFItVAFbY7kpr5fl6JF8WGKEBr
 yCDzqcoyI6eFC8unOGf/VTqH77jo3aKhv8MpwnR+9YEteoAxvPzUHO3bUqxQK5IBCzBBcegyb2Nm
 wST1nfcLAxH5dwm9p+EtNR/4YexlEimPxJEhnganFscFWtubj3RRZKPvZzahsTBzHDeqqFz43py4
 SDhdaHkWDeddTwSyDyUGz9nYY59L8pxkSSp5+4WR5zdossaBTBOmH9HE6I1bAT2XAyZSTvdS6ywZ
 9+svALHBLxJoOBLCTyDJrll/gkTbK9cgG9tyzKCprd0Ri+jqSK7y38zvTma+5yVTIlsFLK/GPSgi
 hIbo0iK2mabkOC2A8rcbHDXeA6xgsgQXAae/02hlEIMtcWm1W7+cRbCviruipXRagDUo3ui8J7Rs
 WsaeaszXm8zPLikm1eoKLz2jWY+CfnLqljTAUbLESCoVA1O2DvN4VzUv62bjO41FyBEqIaDudcVp
 lPGvmLp+QI7V2x+i2mthdaJtyNHTe7SA/QklbN9cnl0KNEJ+wDLXXcyW50KAMkw8i/MUHLh8SgBA
 6sLiRUajzThOrbalFEyrlMcWb2zLEY+havilOnGhsW4v57R/LfigP93Rha/S0efTxQukuY0yaL5d
 1nvmye7cpKvjaElxQbW1XMVhm1GKKjRSzWIQe46MI9cxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.203; envelope-from=christian@quante.one;
 helo=nx203.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Gentle ping.

The patch still applies cleanly on master (209b2afaface) and fdc-test
passes with it: 16 ok, 1 skipped without --enable-asan.

Thanks,
Christian

