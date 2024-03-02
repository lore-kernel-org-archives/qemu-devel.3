Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6FDC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 23:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgYNY-0003vN-SE; Sat, 02 Mar 2024 18:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgYNX-0003t0-1D
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 18:02:51 -0500
Received: from baboon.maple.relay.mailchannels.net ([23.83.214.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgYNU-0003IP-JZ
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 18:02:50 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D50C3820A7
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 23:02:44 +0000 (UTC)
Received: from outbound1f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id E1AB182123
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 23:02:43 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709420564; a=rsa-sha256;
 cv=pass;
 b=ycwGhnfFCLQnasulz6RyIxzE96cVJ4kB2/Br7m4NegSWLQPSH7LPqpx9skoojDKrC+ofLl
 N8q0gJkAJwAMM41pFw+4PPknX6Im+T91cPLtlIagYtkRqwRZRVUS8UX9KRXma+Zsug5V8E
 jVQQn5xC8jpUJQUf0z/lSayLeN7zR8WcMG1N2xxCrKDFujzlLhiN1Vm0nHHkIlDSzDi91A
 kzSOqB6b5MYjlQtto4BlaKfcxlI7AjwpVlaVLuWlwqpgzMsQWYO3kvLxnsdbd5rbv+BV14
 FsJLUvlGj9PprOZLwruLl/UZ9S5U0jvu7MYTdbjh6pfC26B7IGTJXnxFUSlN/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709420564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=1oIeWM4VFpSfjgG+qtAD7Ri5NPhjLGmdLEW/oLud6+o=;
 b=Uw3F8sTTcERZZz0YfVYC+DcSD3O/c1i1BxFt+CXar6FdHDVBN+ozy/5y6RkVo75h+3pbl0
 wq1y9Pq5/TeaPEsC+EBEdrHIIck/DJJHnSasetZFyE5n1d3E21FcZM+norGQvS104b39+G
 yO8DUNCBQXjv5Ov/jFfiU6EiuV2/Wzfmyg/zsa5L97cmkY2ahmG+7VLDMN+SsL9lBhZfEg
 BWjVb+aQ6Ah8QBf1HSFj8X+3sgXCgK7CJz9tR+mPivqi0LpW6v94zTz0vNB3BaItz5MNY7
 QB/Sk8ibz9qOSk5YuUQex3iCZn/UmDOL+gB+c22J55m7BTPokHhaLv1/8AikNQ==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-wjwbs;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Belong-Squirrel: 654369405b1455ea_1709420564535_254202985
X-MC-Loop-Signature: 1709420564535:3073761547
X-MC-Ingress-Time: 1709420564535
Received: from outbound1f.eu.mailhop.org (outbound1f.eu.mailhop.org
 [52.28.59.28]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.58.46 (trex/6.9.2); Sat, 02 Mar 2024 23:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709420470; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Cato5sR0VoYL7hcCj3GcJnxgXQakUN7ywBVV3+DpxiA03uUqpU0jFn5Z+Eq9ee9vbDlGM9eUEyGjv
 WpT0PrXiYp9ASuy2lMdFp9USBy/m7gHtChl6Trdmzy3SSKYVo29oE1tfmaK8/axr/p56w/8KtnjrXb
 BbErMfDppZg8Fgs5Zef0do0kvvmqJgeT7Z91k7XnqALgGoftCNYHmiJFDfuLODKlByFuUpBAGbiro0
 4pi0xN2b3zy0D6HNQpcyy24eJfOnebZM6FAodKAZ3ocf9Vrak+gZ6xLA4sd1MjtAmuzWw+TtTF7ZQN
 zLTSOPkzMiiPRJ6q4UOe4Iny4XX5BfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=1oIeWM4VFpSfjgG+qtAD7Ri5NPhjLGmdLEW/oLud6+o=;
 b=mFF9UeHfFq1noQlr/R7jvI5ikwdZsbQjgcRmCcgaJwMc1jy6iab0k9z9AKyK5L87Xi1+d8XtuM+Gm
 3VIz5Lh2vJg1h7/gFRK1yZstwJIE7C/u++EZZH6Gzrftt+U1c+8HpZQ8RqNXn9aB7pKjSsHSt8qidf
 DKMbzaaWc4DVEMaQy1Nowvs+7bt8txvpHBCXz0dmBarEXVfGCK485iPUA3h8bx2GNv5jz9pPH7aa/o
 6c+mRBCAvraBpyEtr6kFG6+VNkZyEu3SZ0/o5/t1lKkBcWzYboVuQkx/kyUpqYT+tps7wZ8z7pv+QF
 E1YjhlxhHRMAhgY0fFjkjKwxI/iYmIg==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=h4GOD8fZ; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=1oIeWM4VFpSfjgG+qtAD7Ri5NPhjLGmdLEW/oLud6+o=;
 b=mEoCKN+M9c/HSEyguq+k2jnveeV5jQBxHUnQ3sOARzi30XmCtUQztMa/Ec/GsMMuP6nlaEz/yQ8+L
 NH1BBmZ/ezE4W1NYk9tc5nyy/Y3tb7JxZYD78a9tI4+UPwlxyHEz16Rm+hmgQnghhghZMEY2eZkib0
 2hIH07vEqK11o6YY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=1oIeWM4VFpSfjgG+qtAD7Ri5NPhjLGmdLEW/oLud6+o=;
 b=W2PR6QFW4Nqyy2BsFjLu7glR9SAKt1cODURZk5mcsFiXxJjjHAvFKugYdCbk61tTiUH+MmlifXvkp
 IZi6scww0cHOisbtK7fhnUmrGRtvk10Z0JtI0ye1qfnQMIMPLTaIWffIAdEJNjlDaKrM/NHbJewogS
 sOQrLn+yPfALU0mO9KgLiegowKKR6TdfZqaTsN3mHNdecOIGvsVI2skwBQy6YXoeWd9+YD/Ey7b11b
 upR67j+v15jRE25bgH5KtzC9biOewXnPLg8sW0EGQXQ/OQgHBcT/+ihxTTyhMDOOh6sqqZpEh5fcH8
 4uPF9YzOThRd8NhJp6Jy3bAQ5BMkuEw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: c0616fa8-d8e8-11ee-b685-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id c0616fa8-d8e8-11ee-b685-9b9d9be6ef2c;
 Sat, 02 Mar 2024 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1oIeWM4VFpSfjgG+qtAD7Ri5NPhjLGmdLEW/oLud6+o=; b=h4GOD8fZGXH6+waWByonnMM79T
 eRKv06EsEq/zb9M4tgi34k3eT6DLhMRZBzUx7LGm0AyGlnMsqkNdQnRs+bQjF9pTKQcfrLxzQfBqL
 Q9XiJsJiOtLPwi5ChRjftm8UsoY8MId29yS+FIroqqI7Boue0ijYzDvPrhUtcPjbbZ+wVsubHFbEy
 WoFAILE0/Yl+cUhKQmfVetNSxC16a3c8Bf3Z/f2jgEuTkNm058iGmk/kYktG7lvPAApn5mzu2O5tg
 PvhwbEHRgZWe1WNU37NyejQtdfnl8UrA1I8Nr4bBZJZNsrgOMc7vQrdIG5LnkEqbLnFG4WpsgzP+9
 NQH7OBag==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rgYNJ-000qEz-34;
 Sun, 03 Mar 2024 00:02:38 +0100
From: Sven Schnelle <svens@stackframe.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng
 <fam@euphon.net>
Subject: Re: lsi53c895a assert with AmigaOS
In-Reply-To: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu> (BALATON
 Zoltan's message of "Sat, 2 Mar 2024 23:58:17 +0100 (CET)")
References: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
Date: Sun, 03 Mar 2024 00:02:37 +0100
Message-ID: <8734t8w836.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.214.8; envelope-from=svens@stackframe.org;
 helo=baboon.maple.relay.mailchannels.net
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

> AmigaOS4 also has a driver for this card so I've tried to test it but
> it trips an assert. Does anybody have an idea why and how it could be
> fixed? Sven's recent patches don't seem to have an effect on this, it
> still happens shortly after it tries to access the SCSI device with
> those patches applied. (Unfortunately AmigaOS is not freely available
> so it's a bit hard to reproduce but I can do tests if needed.) I got
> the following traces:
> [..]
> lsi_do_command Send command len=6
> qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion `s->current == NULL' failed.
>
> Any idea what could it be and what could be done about it?

I think the Host is resetting the SCSI controller while it still has
some request pending. I made a hack to work around that bug, but so
far i haven't spent the time to verify whether it's correct or whether
there are additional changes required. Here it is:

From 6a807653679fde5e3e09a7f27576c673f335fef6 Mon Sep 17 00:00:00 2001
From: Sven Schnelle <svens@stackframe.org>
Date: Sat, 3 Feb 2024 19:46:07 +0100
Subject: [PATCH] lsi53c895a: free pending requests on reset

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d607a5f9fb..c6bd801a7e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -346,6 +346,8 @@ static lsi_request *get_pending_req(LSIState *s)
 
 static void lsi_soft_reset(LSIState *s)
 {
+    lsi_request *p, *p_next;
+
     trace_lsi_reset();
     s->carry = 0;
 
@@ -413,8 +415,14 @@ static void lsi_soft_reset(LSIState *s)
     s->sbc = 0;
     s->csbc = 0;
     s->sbr = 0;
-    assert(QTAILQ_EMPTY(&s->queue));
-    assert(!s->current);
+
+    QTAILQ_FOREACH_SAFE(p, &s->queue, next, p_next) {
+        scsi_req_cancel(p->req);
+    }
+
+    if (s->current)
+        scsi_req_cancel(s->current->req);
+    s->current = NULL;
 }
 
 static int lsi_dma_40bit(LSIState *s)
@@ -860,7 +868,9 @@ static void lsi_do_command(LSIState *s)
         return;
     }
 
-    assert(s->current == NULL);
+    if (s->current)
+        scsi_req_cancel(s->current->req);
+
     s->current = g_new0(lsi_request, 1);
     s->current->tag = s->select_tag;
     s->current->req = scsi_req_new(dev, s->current->tag, s->current_lun, buf,
-- 
2.43.2


