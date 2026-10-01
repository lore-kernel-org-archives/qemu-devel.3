Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E8FCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDK1-00061R-LI; Thu, 01 Oct 2026 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJu-000609-Ic
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJt-0003Nq-1v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7ESRc9I7KJE1TSxmJ0588VGktohDiV4YQ5OCwpb7uM=;
 b=A+pxGkGFbTSPm0L30rOUaISIfHjbfhIMoqxMctA5nrGWARgWRYZUe+EvvPF6vovTMhgadc
 71GLhaIKkYTUjVMd91pKlPCbMX8NHcgA5FvUtlZ/pCmz8mmxbVLdP9bkxMXNQxMKxNHPPb
 T3NglFJiDzEYvddvwLyFShe4x0wHp90=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-KbRp4TFVO_mZBBprPk3Dgw-1; Thu,
 01 Oct 2026 05:43:13 -0400
X-MC-Unique: KbRp4TFVO_mZBBprPk3Dgw-1
X-Mimecast-MFC-AGG-ID: KbRp4TFVO_mZBBprPk3Dgw_1790847792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A06A1955F54; Thu,  1 Oct 2026 09:43:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 364E31956089; Thu,  1 Oct 2026 09:43:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 09/11] qemu-option: Change qemu_opts_parse_noisily()
 to take the group
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Alexandre Iooss <erdnaxe@crans.org>
In-Reply-To: <20260930221105.2262063-10-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-10-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775658.2086187.4359745063224723732.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=527;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pPyxke0QsUx+7tydLHLnexvkW0Ozi0P0G3l4D3tUcGo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPD4c6seu6FrMmNWADC+rOVpNEBxzx8JUIC
 ina2RqsZdyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5RsJD/92HstJAF2nypHlYW1cW13+1zNzbyhhzcgO4VUNYKppinCNRMZ25v3F9dkXP0VbsWfpOCN
 QJiKAvpE9mOEGCmP/XOshb6Ldp4tFsCLFcF2PhUQTvrSCkxUfrn0i5zo7czW/4/TTWg8uJL8A/G
 3sszXAhy7M0Cpy9Egup7xHC2Y97JSed1KtYgTrrJQp5GMPjfDXkoX8/9Bp221pjkTYkSwyDafqe
 MxZTBQLfd5ApmK5bra+hh+0Q5jVRpFIAK09ZN7OgJyt5vmjI60s4cEhgrIDZfytjIckTCFdHdyL
 1MEdJVOR8v/6HG3NrbINR3H438nrYCSeLuLOwSzbnW5ClH+eOCqKjalnq/C/9b/Ayir56+gkRE+
 0KBBOMuetgT4aZ2q3I6bISnBJHNaI7iodE2pUBSyaBn4EzjtPMeECkd0B8418MNml5WU55tYZVG
 G4QHzDgFi9D8Sf6RjCMR0YHJMMcMMYhO3j2DMlukQBRTz41dUrkDID98hijFINk2CrBgJOPr7xu
 5wA1UYyDaKC04RtPYb1eixz3CB9CVTaz/bJvEgL7e/O8S/IzgnhywQOmOyJ9+a1SXa+ZHe5yh2v
 sEaWN3dfwrfXck5+iVENCs3Po3qMN925ePT9DKtZszlqfFPGdm8NO8hNGxbqA8JrWoaWHCw0rvu
 zUmpXANo3PR2RXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, 30 Sep 2026 19:11:03 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Pass the group name as argument to qemu_opts_parse_noisily() to make
> it simmetric with qemu_opts_parse().
> 
> This change solves the issue of qemu_opts_parse_noisily() crashing on
> a NULL return from qemu_find_opts(), which can happen when an option
> is invoked for code in a module that is not loaded.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


