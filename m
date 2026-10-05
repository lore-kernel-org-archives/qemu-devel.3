Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34E1CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeYF-00027m-3S; Mon, 05 Oct 2026 05:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXy-0001tA-2Z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXw-0002Zr-8L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791190783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8QsHybl36nz70CnzvAHGdFKCJdwDMQCjrpaX0SEWf4=;
 b=RR1VcSre/y0KzheKKcYZjy/X31bVGuyJjI2BENByPDivfdcq+/nT8U4n65F2N/6eVAq4PJ
 ny16EDT7syxmGWM1U04qNZ6/z6EpsfLNTLhDdizXKTCLwEzQcdh1GLuEFDI0MNNU0wjJob
 9GcoqD/msog7Kj5gioQOpkWZxhvOtIQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-MykrubswPua33V3yCenB_A-1; Mon,
 05 Oct 2026 04:59:40 -0400
X-MC-Unique: MykrubswPua33V3yCenB_A-1
X-Mimecast-MFC-AGG-ID: MykrubswPua33V3yCenB_A_1791190778
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04941180060F; Mon,  5 Oct 2026 08:59:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D4BD40E; Mon,  5 Oct 2026 08:59:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/8] hw/usb/redirect-server: Connect usbredirparser
 to a chardev
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: clg@kaod.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-4-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-4-jamin_lin@aspeedtech.com>
Date: Mon, 05 Oct 2026 12:59:18 +0400
Message-Id: <179119075847.699310.1299101589008423951.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=607;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O01HFhykZX7CBjKyC5nM6WDFG+wNRFsqllvLLYFpOp4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqw2bqt2NLqQqB0+qBk39DPQO3NBgscRrtM7YoF
 GzK3IW4DAWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasNm6gAKCRDa6OEJdZac
 5Rc7EACzcAXIV4v7CM0dRUBK/yg4idvYx3WG6L3KSB+lWQyS8HJG1GAuqLAuIF9IUP8uTT2qZmS
 sgR/axuKd59IIqNcPLFzvLPiDT3hoBdnb/aitVDH8a4P51LWD7kd+gU9Cqk7kmwflYlnWIt2/VE
 Amuwua60+VM5wcq/b6JiOjxVuO5r7/uqAQQXv3o7az3MXzPPlYnzssHAzZIhWgTn7xHIItHC+EE
 ACka1i/7/o8lYCnzhGJhrSb+iQj3nvGgJNi5ghrM9DKIr1wK9+8EtYT1DrijdVS5uSKex+6k+TP
 JI97wY3f9kHRHns6chi2BYSEQT+VfB/5nQsC5aGbMIDeBACP6XJLHNmXm/5udK6uMzWC0Ab6eMr
 cbUIsh2bBitcCcu2JVkWDiJwDwwZRWcaTotFHuJlW9sMD7n/43I2VL2ZufFOk6n0sEzbzl2Zq3f
 MywFll3GYUEG85CRfhZGqGEN8SQNWxIryj5tGX0dNRbFiWkdMkfpb0bUZu84yrBjloXIZLR2IzF
 N9xnFFB83iqR7b8+r3PaIXbVYvF2/jugMEL7gHUoBJsnnPXLENeK3f7qmCKLj/nD0Kl5y2dkGEc
 WRZ1stwJnM0pzykvmiRvQgNAhWYxRwJG04hA7o2VmPq94mAfX+tY234XQd9uVWaAPFYwWYM4DRQ
 SMba0ab7cEvnm8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, 05 Oct 2026 03:20:27 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Create a usbredirparser when the chardev opens. Feed it from the chardev
> read handler. Destroy it when the chardev closes.
> 
> The side that exports a device sets usbredirparser_fl_usb_host. This
> side drives the device, so it is the USB host for it. redirect.c is the
> other side and does not set the flag. The library uses it to decide
> which direction a packet may travel.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


