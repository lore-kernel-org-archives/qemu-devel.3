Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9D1CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOen-0000uU-Qi; Sun, 18 Oct 2026 07:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIOej-0000u8-Mz
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 07:02:22 -0400
Received: from nx103.node02.secure-mailgate.com ([192.162.87.103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIOeg-0003jd-BS
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 07:02:21 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIOeb-009Z1E-Ir; Sun, 18 Oct 2026 13:02:14 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 27C7F280430;
 Sun, 18 Oct 2026 13:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792321332;
 bh=xHTz1bCcWMkDZsVgNOTg0pqwzr4MRaOyMms1R84t0e8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NSsf7L41MLaMIDbe1YHCcDTCWKGK1Ci0tGlimi6j/2l9EeQUWDMorcAsyyekp/yvV
 o8XeY/e8PPIvY88/lghcyTGqHoBjS5rOlz/WxYqAvmoZwejbt6S+eZKNfPpTWmMVI4
 OK9NWLLKYBJxrNmb7I9tjMePMn3T+3m9C3zexkdU=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] hw/display/cirrus_vga: do not coalesce the writes
 that start a BitBLT
Date: Sun, 18 Oct 2026 13:01:51 +0200
Message-ID: <20261018110152.249518-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <63eb396c-26f5-9dc1-a7f1-2adb62968db5@eik.bme.hu>
References: <20261018050643.9288-1-christian@quante.one>
 <20261018050643.9288-4-christian@quante.one>
 <63eb396c-26f5-9dc1-a7f1-2adb62968db5@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179232133272.1614748.13533093168132202590@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVZ/mTvVR0syo1BGhcHmpwiDl19cn750dN2
 /y08JFU2Giu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4ar+Hv69vfTD0K+J4HMVM4BS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkqZOJGV2rGZzAbG8h1gtZeBYfLAJ36
 RwtyxBRSZ+49vUZtsbpCsEGE++ApJmXOUs+j6ENPH1DWpN4lrgIKpbARtMCTxq5jwxjiZtJ+0kUB
 UWUip5zE4E/XIl/3VQ3ORIRQOrqYpD9cCIjjYzOHfzJfPd0rEuGjFyZoidhtHm+WoeUOFUAH/QRg
 P+OfPY5km/qzOVXCPWfYkC8dRIZCBp73Tgdl742lubk8D3PFoMK67ud6duvNZTDZfrZlB960E35Z
 3rI3E5JQiyYYIkO5KIZI12Prwt/gU0jkaaNg2Sc7hfVbClI7FgBuKc9YI+4W2X/SYGQJTetpu5bI
 UW6Fb+eoshX6x1qH/Dxh5BxxV605ZD21CuENXFYIaPUkCso8laQbsQGi4T8unrmgQroqvg8UhIDN
 VoU0d+SMbIXKJHOvtg6F+Jug0G/Q85RUtAk1cY/8YYys3RWAQ/V912KE9mvPHUvDbIx/i+m+GUz6
 8StDWCfoiMstty+iVRobalIoISSJasV9y9POl0jcAQbTn1dBZWr+2ltc/WKZ0oDhZQb143c6cob1
 5EM/b86Bv5zwPahK91wEnXzr0vbLkREUcLw08grgHs5RVKfSRsvoPbd193dofZ8BM+oQh77Nu3Y3
 DJPsNjMV9Ofg1ecGMS6f0O9nSf1rWt8UKdIyxz68TCs2y1Nt7jAHDpKQLaMAQ1Zog0OBcFspMiWo
 2lErz2a4VsrAGxr0D6eYR3txFV/LGulnVZPfmLHlV6EFzZxRHvja87t5Rw4YKYlNqitSG2U1GSfH
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.103; envelope-from=christian@quante.one;
 helo=nx103.node02.secure-mailgate.com
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

Hi Zoltan,

thank you for the review.

BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Should this better use memory_region_size(&s->low_mem) instead of hard
> coding 0x20000 here? Also since you only use s->low_mem and the function
> says that in its name already it could take the MemoryRegion * instead of
> passing the whole CirrusVGAState but I don't mind either way.

Yes, I will do both in v2:

    static void cirrus_coalesce_low_mem(MemoryRegion *mr)
    {
        hwaddr gr2a = 0x18000 + CIRRUS_MMIO_BLTDESTADDR + 2;
        hwaddr gr31 = 0x18000 + CIRRUS_MMIO_BLTSTATUS;

        memory_region_add_coalescing(mr, 0, gr2a);
        memory_region_add_coalescing(mr, gr2a + 1, gr31 - gr2a - 1);
        memory_region_add_coalescing(mr, gr31 + 1,
                                     memory_region_size(mr) - gr31 - 1);
    }

and cirrus_init_common() calls cirrus_coalesce_low_mem(&s->low_mem).
With KVM, QEMU registers the same three zones as with v1:
0xa0000 (size 0x18012), 0xb8013 (size 0x2d) and 0xb8041 (size 0x7fbf).

I will wait for comments on the other patches before I send v2.

Regards,
Christian

