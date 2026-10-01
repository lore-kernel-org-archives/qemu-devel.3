Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E6BCA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEpP-0000YZ-LN; Thu, 01 Oct 2026 07:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpO-0000V9-9t
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpM-0006Qu-VA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcAwE2+7Dh5ZlS3R1pc6dFDNVxunjxhWZfPvTM6jXUs=;
 b=dgRYMybTpMFciDnJcwqJYhJInK++ZRUwCYkT+mJjP72hwvsOuBBOAASF1DloLFkRdJT7P7
 QhMy2szBpUw4Ljp+WMi4Ywk3oy+qqfnjsL3GlS2EII90yBLBDaFgr6pgqVpiPcTZVI0af9
 A5DEPLwz4PHaDP6qTShI4BVZivgwlB4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-ktzHLtqJMGiSGQCLtJZR_A-1; Thu,
 01 Oct 2026 07:19:49 -0400
X-MC-Unique: ktzHLtqJMGiSGQCLtJZR_A-1
X-Mimecast-MFC-AGG-ID: ktzHLtqJMGiSGQCLtJZR_A_1790853586
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E18C1955E74; Thu,  1 Oct 2026 11:19:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 198E31956089; Thu,  1 Oct 2026 11:19:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 13/13] tests/functional: add tuxrun kvm gdb test for x86_64
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
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260930164649.433573-14-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-14-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:52 +0400
Message-Id: <179085353211.2170790.4483815438136718709.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=278;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=c774aHTtJ3wN81Ixk1qW9xKt4Axs3fKPKBzHYCU7koo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGfacLQdhHwLcUiMusbGpr24cH9yCAvHgjcK
 zUUTfS59JOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BnwAKCRDa6OEJdZac
 5bfxD/9YOEwtfW2VXOH4iFYvOx/SJlCRy31QumitWZ5YAxpynMjFf36TPjv7fpDxkA9pwMyTYUK
 XJJ4V2wPscWudnLVbNnZUW9aX3vlumNJE2OM6GQ96qHCLDVCZhoe6S9jKSrG28YlfomURHhwkE8
 ayIL5wglol+T6blpdcSbmq6vjfeQqbyg+Yet1M6S03D5PbSfN9uBNShOE+aOqdd9G3o2PhqTvNp
 KwRCi2dNbWLP55Xmja10Q6c1740xr7R8f12GzagBB4qqTyrosHl/gSFkQoRI/c9vjYVGXQ7fqrA
 bzBKPuI3i3An6z2Ea2jEs0EjC5xxvyfKQTDwUExa3Hb7wiiiv+65Ckuuyi8auj7m5MSiv33jRze
 HjJaA/oJAUwqzt2RR+NYsSV2bUYrJyUiHTq43dx4NthM9OKi7VbxHztGtsuRM6cyc+SIXNcauY2
 azM7UlfWDOJo5GUbvdfhn2OMbTtuCRcbpCpleHnzc/jqRQkSsOnP5MyL4/Nv3uF++BjBtzak+UN
 p34UWg6ApyBdHbpHFC+VTkMZ6imm2L8QtJMe0RZQ8OVfKkfava55nxb5PsXpSVaFp6VbZgdsxGL
 TC7AwRtC7cWpjgcaR/yKq+UeFRYTb5/azXXZXkudzjLBaUgGL6WsHre03lRbfI3eHr24AMW8S8q
 BEsaE5WA2UjxyUA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

On Wed, 30 Sep 2026 17:46:49 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> With all the bits in place we can now exercise the KVM gdb interfaces.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


