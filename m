Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA758CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI012-0001Te-1c; Sat, 17 Oct 2026 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00z-0001T8-TM
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00y-0007BE-IA
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWGjXIi+ohauKPxa6AnCMIgz2BTY3VfjUT4j+xlMbRY=;
 b=cDcqWljFqNnb7dYqVef0YuaMcLMLPwvb8wYStosgFJygWbc0UzbsRePkPLVIbXVhCNNlEc
 HIHjcuCA7/nvgUnsFDXDQHOlKONWkWHkHT5vcrf7dP1cWAhVm8OxWsfD7nJWuVuGVP6+XR
 4pOkAYvs1BxFIo/3pej2KU6HdcE1tJM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-64-g9RUdMciZP3HllUR5OQ-1; Sat,
 17 Oct 2026 08:43:35 +0000
X-MC-Unique: 64-g9RUdMciZP3HllUR5OQ-1
X-Mimecast-MFC-AGG-ID: 64-g9RUdMciZP3HllUR5OQ_1792226614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40BAE1955D56; Sat, 17 Oct 2026 08:43:34 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D1F91800446; Sat, 17 Oct 2026 08:43:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 11/23] target/s390x: implement get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-12-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-12-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656903.1619676.10704639085049672086.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=57HFKm3MeVu8Ju7b4FxMYfpW8u8JQfAFxM8P5/CQsSg=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUMZoaZ2EkMz/GDallbTMhrsJQj8QQYKosdA
 UCmWwIos/KJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5Wv/D/Yo3RXPn8/e2RNKGDEvhK6qbb9GUkmQkflaFAID5FYqABI1yf8ugb+ke2AKcbavG0jTF1s
 le4ZnLxVgJl9kPcdPJKmfLWZxZigPsmnAkT9mXztJvFASv7KHHx7Dsf7S8VHJxfh9x4iYnc77be
 gDYlOA9vWzNgQf69ZL7Td1WyUMbo+iLNIn+7kiolJfO1tbEmGZCZKnwf9E/DN5CbOXUO1rMfGg9
 bg/S6mQjV47XQ8NaU7WRhW3M6okqXhxf48+8584fqixFX+9BFWq4R5OZZiLSiTHxswqEkClKtef
 b6etV47xXZkEIABaqyCJPhB4H/EBTyshhc954YwiB2c+kAp4k6euRb7HwYIq1U28xgYJ2Ewraiw
 Ud1QJfx00dxnx/teoPzJXAZrXQ5MUE9zrG+oAT+MSLKYkfVabRT4/X/xRo4eUYIRfdMLG4QjIzw
 g4DBJp8wOjpZrlrrVbiFL5xLGVx1HLMKi3ho/mN9AFwi8QFxCoVcN648G2K+K6jOnQYSsqqgIkc
 4IDi6fF5SFdKH1TcAS9Wky+e03uICZHp06R0QUkWW7o3u3khD+waul3H5wiA6nu8+Qat0RX4hTJ
 nlmE93W/JQx5vxWOoC5yzRhRGIKdhhAcJunaOQxSr5paRP2DEnjDFYX7no5pLbWOmSBdoNTmRTI
 Dws8x3pU7jNIE
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Fri, 16 Oct 2026 11:13:58 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


