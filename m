Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FACBC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 21:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyUv-00074N-1g; Wed, 06 Mar 2024 16:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <info@maximka.de>) id 1rhxZq-0007c8-LC
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:09:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <info@maximka.de>) id 1rhxZo-0001H7-Fw
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:09:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1709755757; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=InKuDc0l/gjetXp2NAmuc6OoHXwShFbzNW0FmSPUerSorkq9GycEfZrmfwpXV/6VGI
 XhL310C/t+zVw4PR4D0utmKmfyOszFQ8s2GU4iMsmoZKb2lz/WUqLaNQFYza7RLxj3yG
 Itu+e/yQ5L8FS2xV9mshs2q++So8TTFheOFXMqaLVVGJyiNk1r/JcEe+3HV+ML1TP3JU
 NdgjSY5vghVt1s4BSKWJGyKwaKpzewN9RQ2IAU8f307akDeuwJ3bTB3dN8iMLM4GCuBr
 gojeEows8As/1zFhYyFmchr1FQjaXv22I7XishvZPeCzbEEA2gL49IZLHa3o8AFEfkEN
 nlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709755757;
 s=strato-dkim-0002; d=strato.com;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=YF8zFMPbz9tAx4AxBHaHiO1/wbg8L5PKI1PZjveRaaw=;
 b=ZRMW0p4FxvbSY3sOo2SlyeSCtIh4HhmsRXsYDRBkWjhRWDO/UOdLvrUcYBF9O6wUuX
 7ofnI29AVbus/yzFMGMCYGChhnJ+A415o510gyNTIuN83B6KYp7jg4+kcZzGSGeHLNZK
 Dv86znliw3BUE2frWtxUM+0UwIKxxVtZvp+hLLfZ8JAkII2rv+bzwU1O2iOis9aOj/ux
 EmYYORhBBnkGGjZJcE6VAwgknn+Q2WV8MsNZy2qxfCYhWm/fE27JuJpQx9075UiF9MEA
 8BkzqBKe2HDRRr8pscjsNOz4aO5MoNh14c2YDAOp15HGzPhVmGcHxTvCLWOjV+kQN59M
 n4jA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709755757;
 s=strato-dkim-0002; d=maximka.de;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=YF8zFMPbz9tAx4AxBHaHiO1/wbg8L5PKI1PZjveRaaw=;
 b=RqZ04BPBGQMXAsAJe2SG6sH3wiOg47wWdQwVdZ3wG4K4+uyR4tWI81afFlZOSIFNA/
 OLz2yRUBW3c3c5wKv2Mnj+cGE9qwTdMSK6gXlLlB4xs/EpvlbZhe2rugt3i5OM0wmBU/
 M60Pye6bOKTUmtnQFIK9PY3ul6aT6A9ZJ0SySChejBdFk+WNPtOV2oDxpIB6h68t8kWe
 X52EqWZM+MDdOHy4oA7TZelHJ7IRZHnK924wih/W7256bITZgXorRSZf+alClSEO3yn7
 KEBs6xIF7lfcfICMkC9avuf9nzpwsAQtS6IS3nZUKVO/4ch1Pdn/Vo6ko1TS6L9z9bh0
 jRzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709755757;
 s=strato-dkim-0003; d=maximka.de;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=YF8zFMPbz9tAx4AxBHaHiO1/wbg8L5PKI1PZjveRaaw=;
 b=yXkGXlEN7PCNSTrEME5UMbuhqNSMMXdK3MyqDNUY+kV5ptaElKxldJkzT2gVGsuUUo
 3csgyfF0EqUrKw0ctSCg==
X-RZG-AUTH: ":JWICemCleucEZGNurnXz/7xIHdyVrBVseu4t8zsQBJLrlG+xkMbI/m4uBgE3i1hBaQM7bDIKr1/ge0kZWL8z684/OOeKaw=="
Received: from ox-live-app303.back.ox.d0m.de
 by smtp-ox.front (RZmta 50.2.0 AUTH) with ESMTPSA id Y6d679026K9HiTv
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Wed, 6 Mar 2024 21:09:17 +0100 (CET)
Date: Wed, 6 Mar 2024 21:09:17 +0100 (CET)
From: info@maximka.de
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <994784261.2558198.1709755757517@webmail.strato.de>
In-Reply-To: <CAJSP0QWcE=SxYqFKj8XiGJgwSK40M9HZzAEAsvhNrTJWNR8T1A@mail.gmail.com>
References: <2048170974.2556839.1709754757016@webmail.strato.de>
 <CAJSP0QWcE=SxYqFKj8XiGJgwSK40M9HZzAEAsvhNrTJWNR8T1A@mail.gmail.com>
Subject: Re: no target for a link in the post "How to access libvirt domains
 in KubeVirt"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev60
X-Originating-Client: open-xchange-appsuite
Received-SPF: none client-ip=85.215.255.24; envelope-from=info@maximka.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Mar 2024 16:08:19 -0500
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

Hi Stefan, you made the update swiftly;-)
BTW thank you for your meaningful posts.
Best,
Alexei
  
> On 06/03/2024 21:04 CET Stefan Hajnoczi <stefanha@gmail.com> wrote:
> 
>  
> On Wed, 6 Mar 2024 at 14:52, <info@maximka.de> wrote:
> >
> > Hello, thank you for the post.
> >
> > The href in the link
> > <a href="https://kubevirt.io/user-guide/debug_virt_stack/">Virtualization Debugging</a>
> >
> > should be replaced by
> > https://kubevirt.io/user-guide/debug_virt_stack/logging/
> 
> Hi Alexei,
> Thanks for pointing out the broken link! The blog post has been updated.
> 
> Stefan

