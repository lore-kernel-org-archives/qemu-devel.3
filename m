Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bKfPVTXN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbfX-0006Kt-Ht; Sat, 24 Oct 2026 09:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfN-0006A7-3b
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfL-0000hy-Ib
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLGSyb03A7RENSmax0Erog57lnN3MhjGCQ6CU2rXKgg=;
 b=bKfPVTXNC3T5jkYDLwrNCjM/k5xa8ehZuYK2WLevv4yqcIRajCY9LK2lqdcU/OvAbv5+a8
 r121owLkG/j9vEQKFVNUyQrc/Jpr+ZaBNsdC5k9ThQsRKpVjcpBoJJodYtO6JLkXuromlH
 u1IYLkXoqOdB738u4KRZ+Q0pZiFY4VQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-ZMnWrq_FOgO-6Rn6OI4_5w-1; Sat,
 24 Oct 2026 09:20:01 -0400
X-MC-Unique: ZMnWrq_FOgO-6Rn6OI4_5w-1
X-Mimecast-MFC-AGG-ID: ZMnWrq_FOgO-6Rn6OI4_5w_1792847998
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 250D8193FA91; Sat, 24 Oct 2026 13:19:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A46A1956087; Sat, 24 Oct 2026 13:19:53 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 08/19] tests/guest-debug: convert gdb_cmd to an
 array
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>, 
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Klaus Jensen <its@irrelevant.dk>, 
 John Snow <jsnow@redhat.com>
In-Reply-To: <20261019192704.3220373-9-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-9-alex.bennee@linaro.org>
Date: Sat, 24 Oct 2026 17:19:42 +0400
Message-Id: <179284798269.974117.4596200400689699748.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=607;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SfOmcJDqMBaXTpLyvhR1EpDwKgRVqOSU69uSbpZw5ow=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3LBw+brxO0zy1Rz3sHy9UdnDpkAhUznedj2Yf
 qmTVgR4H5+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatywcAAKCRDa6OEJdZac
 5X/ND/9T9iRN/IQbUNGnxHGwqaro5jMmMa1NAFdrQTF45fp8DH8tzBDcSTgfR3ULExSbc5WqCTR
 DHgjVK1j8M4BgJJi/iLFPj72dbLlaQYsyNU7aG8EV1d6NWaBx9147tXD3n6M/unIzL9DdYbA4VN
 G+o/unazM+hueWnCu4V2IT1530g5zXsqwcXO8s/8Ow8DV5qbiVA7UTW7LqLlTAKvER1YAtfPGzs
 hmdYcLQiHHa2qbB9YzP2PWKPWDIm71B/edB97eK8zLAPc9M0JmuEPWJMCSxdNP/CetW8Vo05UON
 q6mcoMfowR2JukO1JJ6Z+HNzLgkZw0jDutxfIMMprybjj4+oQWHZ3x+xyxj3Rcm55biMzOpr+ta
 z2BGOiGru33vferYnZtLFmMfnGKcm0LjbAvXmu9Y267o/s3xQZSdXZ86Qvi1tUD6tfLB2tJs5dE
 cQBsCOn5EnZf85sO+ps8cFzCE0QvorPJWo5qCXCk81eF5gHys381+9AobXlqhnfHLD1BktwsRKO
 OsdvjJckhYfvvgw9XgR9xcQvckEoBp6GAaiFIKvUqQ4DxHuNU7/fTYuVB/gZsmQtP7F+o4/X02t
 WSDZ3NTyyH9927eCRePayt7lDy5UMdEjlvw1OlKSRWqh3DLOHuf6s8OXLj8dJidtBOOHPi92O8y
 l4oZGWucTFSEgOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 20:26:53 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Passing a plain string to subprocess involves making sure the escaping
> is correct so the underlying shell doesn't get confused. This can be
> tricky to track across multiple  processes. To simplify this build the
> command as an array and execute gdb directly without involving the
> shell.
> 
> We add a mini-helper to make the log output a bit more copy and paste
> friendly.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


