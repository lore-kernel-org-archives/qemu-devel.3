Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F887CD98D0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQGa-0003vZ-Fu; Wed, 10 Jun 2026 17:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGE-0003U3-OF
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGC-00068u-5M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAzpHow7sB4lUZg69DciosCnCbjHXraMMpLdISFH+ZU=;
 b=BYzMvIPqFRUFw62P6+wa2YqWx8CUB1GTE4tK2Aqo7Mq1ZEUE8bumFiv+6oI08GScLDY73T
 zAJq7kxiSi5OA7cs8Jcgqgx8dbEvV3/oo+zh0wk0sHSknN/kpHaTe6b7i+jY2hNvlIyslS
 BmqapsUOC/fcbUZQpDBHhzT13IZ+QpI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-WaJk3vaUNrijFPxymae6iw-1; Wed,
 10 Jun 2026 17:14:44 -0400
X-MC-Unique: WaJk3vaUNrijFPxymae6iw-1
X-Mimecast-MFC-AGG-ID: WaJk3vaUNrijFPxymae6iw_1781126083
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0B2D1945117; Wed, 10 Jun 2026 21:14:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A4831800347; Wed, 10 Jun 2026 21:14:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 10/35] monitor: move monitor_data_(init|destroy)
 into QOM init/finalize
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
In-Reply-To: <20260610123415.2883603-11-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-11-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600335.209622.9830819468096650454.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=478;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+eJrqtIwhi8IlUHTk+notkMuchVMsJaJnNGDny+5DEE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN/vze0OHWwz0YCt5owjmt8KIeQcikWoBwYn
 gQk8JElH1WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfwAKCRDa6OEJdZac
 5cQ1EACbUyeHKI9aGA8ZjGXEewXwiFZNxCtPSdFMb5DZFW3+xM653YgzPn0ZfS5bgCm44taM3wH
 xymxTApx6G5+whtBldOR6rReMRhV7dketATQJYsOcmMDHANxnIcBgrOGutCr7wBtHBMpe6y798w
 /xvyz1mDngqmH6QS14mtdK91l8u6WTXWWwS52rn03T2KavtMqKfZerT5SX9jaTofWtChMwknyJb
 GfFD/T98tOVePTMnGHsXrcfzbL28uKiDzMV4Xiwsd4sH35BW/zL/VhcfHpPYldMCmvHq7MYbbZl
 YeMOd3GgbKmSu5ST1hV+M9CQ/OkBIsv3hjFL6tyh8/8KXMouZpFdWPtmn7aLADPhM4EsNtVnS7F
 13KJlAGftjOijxHhqEZ9qRzvUu5fd+ubrJE6nKBGLWiyptiDGARr6Lf48UaVpvxgotI0CVnWOtN
 xoRE0B3REOT6/SMq+/WdP99PP3/mtwI62F3qNWNnngD/Y1ZTdbO4NdCBMhLP42Slcw3QAH5gStg
 NboHWxtWdM+tQx55/qVgTJzN18syKie5CjLmPHUDh7IHEGHCgVgYPrkiB2x54Ai/ENZZf5nYOHW
 ic7ovKRlNV1Q0FD9a/UJK4mcgupn/bDaYBYK4AXvoOXuQ3qVYCcUhA/6+8JjCOhDZ52xHiYVhw+
 /FBC3grHUTZ3/yg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 10 Jun 2026 13:33:50 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Start to take advantage of QOM, by using object init and finalize
> methods to replace monitor_data_init and monitor_data_destroy.
> 
> A standalone helper is provided to enable the I/O thread for QMP
> where appropriate for the chardev backend.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


