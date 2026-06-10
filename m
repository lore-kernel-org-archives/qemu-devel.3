Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D99CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQG1-0002xh-HY; Wed, 10 Jun 2026 17:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQG0-0002xJ-PC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFz-00061S-8t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkvqgh3T23uxH5jf9X00+6u/CkT0YTVjk7Y2BRt9bMY=;
 b=TMXGzQwLAl/p2m69pdi4bf9MNix2LON3TWmDa/Xi9UPyIA//VpslJyMEpCdtA1dNiMoEip
 mx+K38SUDr6Y6ABBUHfj9r+st/vaCdnrM8Bxs4EtHp5oQIFiuyAWAuJwzHyB+sewFlrCSG
 QwnzNaSTVA9WVCtRqApDVXdOZ4SmAn8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-UIozI4T3MZOmmIbr8Hp6qw-1; Wed,
 10 Jun 2026 17:14:34 -0400
X-MC-Unique: UIozI4T3MZOmmIbr8Hp6qw-1
X-Mimecast-MFC-AGG-ID: UIozI4T3MZOmmIbr8Hp6qw_1781126072
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1210818A1EC1; Wed, 10 Jun 2026 21:14:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C18613008B35; Wed, 10 Jun 2026 21:14:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 08/35] monitor: add 'pretty' property to QMP Monitor
 class
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-9-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-9-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600329.209622.4596653549199804487.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=348;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NuEHzcQILL+WNERviE415gm9cw6Rlb9q7JV8JDZ3PbE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN/iU5L/P1+aEUDgXKV6hvd6vKZbM/1X935/
 JuoONfgfRGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfwAKCRDa6OEJdZac
 5UX/D/sFckaQZgvRSxd0CcauMKzvrWgIlxxTws/Z3ihQxA5gcrMcAX3ap+AkXtEnfQFdAi5vvLJ
 PnPcR+of/qaUJmnRE23dMURwn0uM2UO2cWWmIfan7Thom6h1RPWfjDhjzU1N2GngpzFGrq/jC/i
 gSbMCJohTdZoYW8mxTuzHXVqoSLVWUD/kJZCUZ2YX4TuYI2+pllw8nKheZHLg9u+uXLdLOwu3zf
 FlzbhhU+3/iWURxde5sjxOXIYOO34AX98oALGbFivGv/sbytq7qYSiMPdaz2NR8e94B8nRHuQQ6
 bpagNtGl1gv6fYsivGsjmc4iObRZQguEuMeWLbztZAXI0+H5WeB9LR7cydFr6tZyDYB8QTtRVrO
 azpZazi6kA3VIHILyNgD0c89aMCQUp9r3QT0y0kNy7FXZTQ5rWXvuL04xIR3VRzOVZqEXM4SElQ
 xVb61U9ImzvR6mjMw/hSlL982ae08RZgTjCMtGRFTBIiOTJ9AeKipK2IRYwRuPFbvh7q8l25nva
 CqCorm4FXRywAPYPdFhFZ200AdiCXpzXjcCXONkFC/uY+3rnW0rJIlZYJOKDz9plcjaX2/vebyj
 up9l8KsbMqAJ3mVQSj/RFPCVau4Z1rfqpdNa5Ia+14TByBYWL592hp89wLVFIRXfEWjQK1D1IEA
 T939jh5M5N9ppqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Jun 2026 13:33:48 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This determines whether the QMP JSON responses are pretty printed
> with newlines and indentation, or compact with no extra whitespace.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


