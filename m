Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKh0HZ/U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCDD-00044d-80; Tue, 20 Oct 2026 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCDB-00043e-R5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCDA-0000qw-Eu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE+ZUqNdVajXAohoYNIk2daa0AOxLKJmfo7/nWpLMmw=;
 b=XKh0HZ/UeaoHoqr37d5MaWoJPLScTj+KMNKYBQLMwonbFZq8dKlh1XsCbY68ASr7pfhtc9
 DKMdp1jHBVP61DAPTil4Gs3cey4CGx1RqfdQlW0oXMRF2lAa7ne5dimUU8TvgfuPaX1SA7
 qok5v6kQBQI0ZfhWfhpsRTjTcy4XHto=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-B-fdiTJEMDWiTLmXPl8LxQ-1; Tue,
 20 Oct 2026 15:57:08 +0000
X-MC-Unique: B-fdiTJEMDWiTLmXPl8LxQ-1
X-Mimecast-MFC-AGG-ID: B-fdiTJEMDWiTLmXPl8LxQ_1792511826
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A88B31955EAF; Tue, 20 Oct 2026 15:57:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7318D30002CD; Tue, 20 Oct 2026 15:57:05 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 12/12] virtio-console: notify the guest about
 terminal resizes
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
In-Reply-To: <20261012-console-resize-v10-12-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-12-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:13 +0400
Message-Id: <179251177300.3780647.16075488524721632131.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=325;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bx+Czc8UAp1TRBt7leUWpn5FpP7dQe2/aeQU8hIQNKg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148hv4ja2Pv844sFX4KGfDtTJDYTb8ViBoOg8
 ZD/05Bl5Q2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIQAKCRDa6OEJdZac
 5Uq9D/sHI1UWIm8qunJtDT6Kl3zofyuJg7jTTGF1pN7gXtBIaYEFyvK6PI+jRapss/MB5kySrfQ
 jEmY4Vku99BRQ98qxHbH4kvVn7uzTjVbgg/119moo0tBxrPdQ/JfoVJiwUdfAmrDb0K8lKURxjp
 twdwJVCedjP/YhLMYlqCrgzyMlDIb2dkyxmSPxtvoJwMOICxgnsmJ8qb5HatmRzu16rYgmL5DqJ
 ddNUYuvIlloMBGEytgSesnThmZsAKBFIzNITypnrEEQQ4tNd6vftMSUe+lWk2HF6257drHsfudq
 42wf9HNioA9xXn7ZiP4esDtzQt9NLHoJ1huPwfftwpZMKMab6dwxS68ohcjQ7hu6nXh+LiiTNxx
 BIGV9OaB5XIJ++fJ/dghkFGEaJ5KLdeHC+dFw1najQomxOC4OvuvvREsdJJfiDmCoyP9wPEnl4z
 cHX/4OyCQxYe6Lpq5ge7vw8noLAG1NGt6ZQx8poZ+rpsKr8/UjghE7M2OJ6qHzRMKTx8BcJRm5a
 h7BbsHTFQXqFXJTeYRzZC1FJzCj1yfE8JDzr6pE34ulOEnTcO8yorSTHTloE91m5hZk+ldSx8m7
 GbD7i4RRq4KDpviC5sdVL0cSZfe2PRxlDmJcEMd5ddJDXVwW1COb2NAukCcvkByNhQjQTSSjoWY
 JHndZgF54aFVADw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, 12 Oct 2026 16:05:11 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> If a virtio serial port is a console port, forward terminal resize
> messages from the chardev backend to the guest.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


