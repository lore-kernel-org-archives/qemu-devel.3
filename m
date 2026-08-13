Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83051C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRbT-0004Bo-RH; Thu, 13 Aug 2026 05:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuRbS-0004BJ-IF
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuRbR-0003Wk-2j
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786612796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjT6+U7aDYWURMjl+FQuKYjQptjexuV59wU2cbDtCAs=;
 b=MzJ/R+F7Yycp1/w6WvLnnlrxIdM2RoTZc44p00NPnL03s/brK14G410PrPNY2tjoQOXNCr
 JulPNT54bApr29Sq3X716bGFJSNjSzwAO1+SuqKjAJ6Q/GXSjsWgvFvPMkkLOS6cJKECnO
 meaBXsaCqd+dlbUpj1CwjB0aSBoA8SA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-ycEEgxQANkSMGfptX_pQOw-1; Thu,
 13 Aug 2026 05:19:53 -0400
X-MC-Unique: ycEEgxQANkSMGfptX_pQOw-1
X-Mimecast-MFC-AGG-ID: ycEEgxQANkSMGfptX_pQOw_1786612792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A363419560B0; Thu, 13 Aug 2026 09:19:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 547FF195608A; Thu, 13 Aug 2026 09:19:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 19/23] monitor: Better express monitor_read()'s
 opaque arg is of Monitor type
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812211708.92824-20-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-20-philmd@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 13:19:45 +0400
Message-Id: <178661278568.4028275.16886451384718465957.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=335;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xzVwyAL10HGHW8WuPaF+KAE9W2pYUUcBLEm8ISQidKo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfYwzKYL4a9oNtDGlNZOh5JAg4VCbPtaEn9zty
 fSDhLLBchiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCan2MMwAKCRDa6OEJdZac
 5TELD/48Adl7aSabbBoZzThQ4ivw0D7kABEmbkZGbtNLBNG1Q0mVLMyhGw9/P+U+yhPs9rMHvUT
 +d9Ic2pVAMiIeTnOhzAtALzxz6pPMPccRbhKdeyCKH03RByjxPnQHMNe6A8E2BbODGoYGJMaaY4
 efQ3AHYZ71ygK2A6kAGoHGyKjAm/tcsAG+xBSH3mHQR2XtR4N1tFPbgcSULDysMj2/k/X/xaDb9
 CQl/9iWTtd59f+BMrUTrKpNkd5Tcku+PCH1AKOMqwy3duNS3LXJzvdS6DpTWzKhhA39na4s20L5
 2GoJdxGwVM3kJpSP1db/dsdn6HgeLZT5KeVsIXqn0aeygXAa5xMZ/5vPiz2uKf5xttPbnDcIZeN
 rYFj3ac4ztHZpAXZJhJxGn6fJcYq6lLbW3D2JXm0vmnGgYiA37MsoulhWG22RdlkcqSLois/kYT
 r0GWer0SCl160fhk2z3mHnV4gYJhlKF5b8qKZDvmyh55IRDRRv16SvQjO5fWb2503jmfZhc0pUw
 cDzJIZ9dUwnJncuZroxwuP8GSdX5lRlQCOOdOn6Q0c/PxduKBoLTpGOJc7SY+ZxVLRd4T0prpWI
 DP8cC9JAoA+2lw+cxHgjCgUmPR1sJfgpq49AMuMgFwYjUDLgWHGkuHVvwmmSmyhRpw7O+nQHVDl
 zE2dLIGIDdc5pEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 12 Aug 2026 23:17:03 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> monitor_read() is a IOReadHandler handler, called by
> qemu_chr_fe_set_handlers() with a Monitor* opaque argument.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


