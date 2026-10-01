Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213F0CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEor-0008Iy-MB; Thu, 01 Oct 2026 07:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEop-0008IV-MH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEoo-0006N9-6s
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TkeIJ6Euipl/Rizp/1NkOLHwTcvHNFHfidZ3sL1TeM=;
 b=O21JcDsPKEARLeHb3u+jBH6IyaFDNDhrn4QMorfKwl6k3L2rX+GUmj7uiVNP4OX7pzAfJD
 M4r8YbWzLXEnbMsK0IfPdFR38TrIRjrunu51tlQeg7X9zux27fLfrFqyxG1L6f+0R+hmui
 sjcI9DZHa+Q3BjzOK0h+RX/IF0CwYWA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-DLyhwhy1MOi60UDNeBYOrA-1; Thu,
 01 Oct 2026 07:19:13 -0400
X-MC-Unique: DLyhwhy1MOi60UDNeBYOrA-1
X-Mimecast-MFC-AGG-ID: DLyhwhy1MOi60UDNeBYOrA_1790853551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AC6E186BB06; Thu,  1 Oct 2026 11:19:10 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B05311800352; Thu,  1 Oct 2026 11:19:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 04/13] meson: move gdb detection into the top level
 build file
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260930164649.433573-5-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-5-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:51 +0400
Message-Id: <179085353195.2170790.10706862525211125318.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=381;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SP7lzusc42ytwRQSe1gGQ2LnH20BeB0yei8I2WSxH3s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGedUszKHQWmfAdnMLMfsRhE9xC9QJjWVGPS
 ykSQRbRIHeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5cPgD/0V/tT2zaJaee1htyJYFfWqEBjU/rsCCRNRr4b0N7ytbVekspoy0iLSdTyLMAw0+HUsLrK
 GDKQ0D10YyzX80qN9cxWEkJqUKLXKW0NBIPp4FFN67vsLx+yCS33rAWFbSdwk4aRBJvYS11xH0q
 mlc3XLcJtStrfMat0c3TXZykALeozEzif0l5JoZcxdHp+TrCQ6UrqIfKx9ca9ek69i3XFy8M4xC
 8kD8WeKXM5yhaNUNNhVrClAbZhUIvF2/VYXqIjNm4LYfwWU5rUrbFISv3m1BUp2pOtn5+JTWcl3
 148SU9kQIvPVKBQ93/UmxE+WXqeaoN/ymmgv7wKlfeZw7Dr9ohBlGDwd1C7VNpcgUuvJYO5IpeT
 gICYXHCM9sCS8Oj1e4v7kcf8UmsbFuL6TuXElsff715vfsLFU3alw3Zx0J9Gxi9DpKQXxr6lRFB
 hb3J1OpVgXqSRf5f+woSIDXYGJzByK/Db9eUikWdx1TwQDp98jj9VUUXosmQM77/kptwEVUXSnc
 dM6HDZoQNTQ4mb0k26zFWBzmKMNlayjE5siQTjQ+EG5WYdsyhukagRbmel+gP6vuorXkA7pMmyu
 Dxrb4brfSTorp1Ise/cFuBpOahdUDw2erQm0MBf/M2jw8TS8vbtDEb380a8Iz+YypW0ZROxX3f7
 wIDVuffobxED1ng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, 30 Sep 2026 17:46:40 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Currently gdb is only used by TCG based tests but hypervisors want to
> use gdbstub too. To be able to test this case we need to always probe
> and report the gdb we have.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


