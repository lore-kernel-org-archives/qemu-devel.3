Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBD606A336
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QY5/lLrd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCCe-0003yS-IX; Tue, 20 Oct 2026 11:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCc-0003xy-MD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCb-0000mB-BA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ez0r2qwHUKljZkl6ISNO/q0opHdrg+iB8oYEa8eFPd4=;
 b=QY5/lLrdABSOQHB0rOhR7zEYbnxhbOD5yQypL0tRB6u9ZSDR+5nBLgIKW+91bEMZe80tXD
 TyYl/mgzYXvgeL4mWwhRrNpMj9mvn1SU3LekS7jDsxUIT0f/03RMiBjpBMu7TJ439lQY3/
 m+jZWVQ6Wbkzg6I9/LUsjQa4pmL5KlI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-mPq5Vt9NP4CKdnED69VTsQ-1; Tue,
 20 Oct 2026 15:56:33 +0000
X-MC-Unique: mPq5Vt9NP4CKdnED69VTsQ-1
X-Mimecast-MFC-AGG-ID: mPq5Vt9NP4CKdnED69VTsQ_1792511791
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC478195419F; Tue, 20 Oct 2026 15:56:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BB4030002CD; Tue, 20 Oct 2026 15:56:28 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 03/12] chardev: add qemu_chr_resize()
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v10-3-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-3-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177293.3780647.4584393074770885595.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=316;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3nGBqQLiGh2JtlVLbIvbBTUkFcktZ4ZNcaKJX5NaHpA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148g2hjM2KD1eB6d2WRJsvgHyXPKSN3OE+DcZ
 9NUecZKsuqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIAAKCRDa6OEJdZac
 5VsJD/4tbUrxK+epqY1UJxsStPfSrQBiU/8lSnsyMF3Bfmr6Ic0aCT9066xOpvrCUcMBovsbH8i
 rpmF8XCpUbls8pACT4E/T+e3/XVNRhV3ueFQJhpUR0e3XxELz94hVirngZTLDh1w5eOY6wJ16iY
 U7h1bi6xkGl1e1H2eHBThFHwFsuMRfSTu/prIqk9Dp1utuK6DEGuU2keQ5jfsurIOZmFwu88YUO
 fHUua5z3sR4lwDXmv3ovr/xmf1HH/DmrlhO4No6xFAyZXBHL1uVDWZuZDXDGwlH58bUHZLK4gI9
 Iu7wtx0C+Hn1iTbhJccKeGUCRoH0v+TI+8AILcp7ObGwvKFPTUTFBCxEWAhfiVsn9ZwmImK4yM9
 3y4ux2dYV2dPbSR6eSLx6GU2mhS9i6KGiU46GcWNLe8vj6Ab8okuzCxvCMYgCI2yfTE5pg3sAok
 j6ZsGhomIbiPR+ATYrRh4hgqYFUWPA8f4I91WMAHqGRV/O84ymU6ty1BRzrJifl2Bhd30s3/5gw
 hO7bIVR4rME6ueWQZ18kak+/Vbv/zf7H3lm+DXai/X53CUD97ODY9tSVMw3ux3+hMIzAxJu60es
 s/rZGlDFvsAlRRfX68eOR2+4eda32cirE2qiJ8wMFzgpTgsAXYK/dAHmwHltapyYOoZMMrMnmNw
 tK3ZL6HCk+4ELrQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, 12 Oct 2026 16:05:02 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> This function should be called whenever we learn about a new size of
> the terminal connected to a chardev.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


