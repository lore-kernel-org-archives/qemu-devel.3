Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84498C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrPb-00062j-AO; Tue, 11 Aug 2026 14:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wtrPX-00061a-Ba
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wtrPV-0004MS-E3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786473672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3FZaRHhb527ZAgzMNpvxvigEtQjbaBZ1+mxwVcQVBQ=;
 b=THZTxPyAYaPQBPgNioDigh2SIfl2QnTsjFXb+a3tfaPYoFX6q9N5xHdu7jUSNaS/iYplws
 kPhc4yKT/Uae9RZZmkset3V7gWoimMYWYw6b1/xf1gyAXgZ54Fk4m0/6wVylbTv9k+He3T
 rjAjLr/eJZQGRS2g8szhL3VYLqDOiWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-XGne7hQsPeqcAx8kdRyPmw-1; Tue,
 11 Aug 2026 14:41:07 -0400
X-MC-Unique: XGne7hQsPeqcAx8kdRyPmw-1
X-Mimecast-MFC-AGG-ID: XGne7hQsPeqcAx8kdRyPmw_1786473665
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BFD91954B0D; Tue, 11 Aug 2026 18:41:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C722E426; Tue, 11 Aug 2026 18:41:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/7] hw/nmi: Disconnect of vCPU and disentangle
 Monitor code
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Corey Minyard <minyard@acm.org>
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 22:40:59 +0400
Message-Id: <178647365980.2351431.537322099093803910.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=446;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LFqpoNkYSW5zHmghRpW0n/kc/SZ8dPh8CiEBeKGmCNU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqe2y9rBU8XOCdyEYIVHcuTP5MkAlV20cyCLvA1
 WZx8PcEhgKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCantsvQAKCRDa6OEJdZac
 5bAmD/98VS10/YNL+BtHsdk0g6/c+hhlslOuTLOmXSMDTFbJYU3Hp1Ma94Cg2HNxLmpQs96uGVv
 7ndZpF5fSs077QjvPaEbwlRsoHoBA/7anxZeyxn8ENJg257MtdyPMiBho1adZLZwNWmGuXpwPSz
 S+ghiVIUBNRW/DeESt7vCdUwHbq3DZkwDsBWhRdL2wev8UULMcPU9w7MjZfrr9qzKq8Mn4wreAo
 jUTQ5LGRWtX/5V0eZi3MxTgVdGTYRjQJEMex0/0H/1tmCyCVsycWsMubpl6xTFUyRrNEdQ9+l8h
 r81OVO2RLQou1DH0ve6SV6/Blu8TDQlqM/ZghDcf812iXhKXP5PNoPi8ocEwYIfYeE0/+C3h95B
 fU/PH+W0lOqoJa1miz6yTOA+sCgwcCODI43SS/iRg7R9+lFGAmex5corQ2i5N+2JhlZuIvd6UOG
 UgONek5KKOtXJRNdE5bYWI9pAaxvZt52EgGtVSGRuDoVoGXuBGOOUE8B5e/UQCeM04k6sRsp1Uc
 n5J1fqH8gpM9gcsCWW+rL0mURXVBbiqI8skZQkc60CW8blsnQn7/HXU/MVa5OEFAH9VNDU04DzM
 FMFlAWJiwBf9tvQn4l6/hKgPnaODvYTSBNMmHGgtEnOqIuWbkHfuIc8VEcyjTNBXPZFmyNAAQl8
 r87F+MDr8t4I/OA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Tue, 11 Aug 2026 17:49:23 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> hw/nmi: Disconnect of vCPU and disentangle Monitor code
> 
> Since v3:
> - Rename trigger -> inject (API entry point)
> - Rename deliver -> raise (machine-specific handler)
> - Do not mention 'cpu' in HMP doc
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


