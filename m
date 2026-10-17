Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE9BCCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI013-0001U3-GQ; Sat, 17 Oct 2026 04:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI012-0001Th-C5
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI010-0007BO-VB
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAqMk0dQQAdQOhlb555+v0Ubtb3zfGWNfqx35Fk7Zw0=;
 b=RMnZ2i92482eJFjnnXN2kdpcuYfLlwfFJkE322ArAonNTaIEFQMN6K5ZgiEimzQQoM1hmm
 PByCxpImaxLGBalewjb2oYH+756/eM6nLwLm7D/FRGaJOJA/rK7fwpF0SqRhazwdEyKeZT
 jpjZxo+8FkM8gETPKo5oQcl1MpIx2qY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-xuMNmmFbOay37aPaiY9lWA-1; Sat,
 17 Oct 2026 08:43:39 +0000
X-MC-Unique: xuMNmmFbOay37aPaiY9lWA-1
X-Mimecast-MFC-AGG-ID: xuMNmmFbOay37aPaiY9lWA_1792226617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B04071954B26; Sat, 17 Oct 2026 08:43:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D28C1956087; Sat, 17 Oct 2026 08:43:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 12/23] target/loongarch: implement get_dump_info
 sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-13-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-13-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656904.1619676.15700085456214621407.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iUByKI86N0eVkJ4Hyesz/kdLFzqlTRV9bCcM4urEa6U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUM7PKw7mBJCIeWKHOjMA6ArWdyNnSKCsNHw
 hEqM8bib8uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5T1bD/9gG0LzJ6aFO2gMDjS5/cyLSKsyx+t9Hj0seeoYvxhN36BtasebFPPS/pX9dCiTuHoQciy
 mWDSywgsnKZ5vBtoOgVBtjfUbCbWXd/BIKmz9PIxnpa7nP5ceqgEXsNTxMmJaQ7tmCXr/U+qPdO
 LC+7/xhOWFdcVnrCa+7/4GXIhYWZIe6rC1pSWadCzCkyrx7jtcO6K/RvAggk+/tFp0yX2eFQvbN
 IA39zD0GFoTaqVC5ahgTE+OUOmbdEMESeO4Ha7NA8UFD1gfTWpj0avtrVyktEb/Hu5pI8yZnqGu
 rvl5vC6pewh4a0eHTllvSWKa1KTJGLu6U1UHXzdgw4fXdCBn9l9eqxDHqIkDdGA3YbE1ysIOlac
 UmHehrpuzF6jaegd+zE1OWcbvjHlXp/lEVTAzX46gXJwwx7n53FXdlgpTsvtxgmFvOHvZWYGOjO
 ZSrFEby/rfrUHQPdW45QsRcUDsSp7Q9+vDBcX95ImUkHDATht2BPsKDoYs08JJ9HieJ1yyTHSHP
 YPBvOLMl8eZmvYktGQMZTmGrYu8bJ5ZDGQI3vWrcYNz6lInik1JJnXGUrDeBeuVf2mWv1HSFOrw
 5g4rcD4l8G7ht14Z3XTD9ODFvHrS9si0M4L2FZCdybv++Y3S3R9TLUjYi+wPMyTCvb7VoB4+6fg
 yUjo1edlO09hVPQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 16 Oct 2026 11:13:59 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


