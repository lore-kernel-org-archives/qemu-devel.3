Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07726C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5X-0000ZJ-Ut; Thu, 24 Sep 2026 03:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e54-0000Sn-S7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e51-0001Wi-Ee
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFwxmCUKFI3JmyQIqrhdlmSdw8j2ug1yYTnxxXe137E=;
 b=hpFVIRKAD1MGWlzdIbdL5pKVMklBtal4seHGZSGmasjxnU9/Z381Sm17Wutl2mdYAFARv9
 LhEFVFUaEItJbM6RVfzOn75PqD+lX+0pR20x0ccTpe1msenQVd8cA/aOvnCdZVUpqmUFng
 PCxjR1M03ECHFmqSLiehuuRVDvQQph0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-W4plprKzNRie7BtALkMNJQ-1; Thu,
 24 Sep 2026 03:41:15 -0400
X-MC-Unique: W4plprKzNRie7BtALkMNJQ-1
X-Mimecast-MFC-AGG-ID: W4plprKzNRie7BtALkMNJQ_1790235674
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 076811828AFC; Thu, 24 Sep 2026 07:41:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21C901800351; Thu, 24 Sep 2026 07:41:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/10] tpm_emulator: Reject TPM responses whose size is
 too small
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-3-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-3-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566484.1794827.17453731912325600011.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=335;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mIaoCaZpp6DGTdfcG9125IVdG5U7TTjNVhFUDjXKuUE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQS2eT5pa2e8MyGh1BiLwVhwQCfwC9S1Xm6+
 BxsZRRGeSuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEgAKCRDa6OEJdZac
 5a1sEAC5aCnlzgApQ7pOq20tReX0/Ezz+O+dwo75ZdfgfaVFViRBNLsd49E5BuKu+29XbdyM1TB
 VhRSVtRlQrWYTuKuBUAclJoYlCIN1VxGYGonBULeT6ZSPyHd7JS+22GLIvGrw4WM5ZOj3UiAxLY
 mIAkX9ffqgGBfUkCLhsw3Ies6x9Nm7wpUGlirN7iTRbjAD9fghYsqG92XcFK2zatc2vcdGARrgS
 vYIKLUjI3zdbTOjJoPOreX7OEID/IXUOSiPfZzE39y75FJ+DK6wON6TwlNjalT9IV47XzUz/M9j
 Ur3q3ble3cjbh/ZMZ1xmYQbY44gj3J5wVrXNO0E6H488M/lcfhqNwrNVHnpWD+uP/BHE5irhM16
 ZcOTs+9qK6HNuP1KGupyPgRonD99j2uUw3I4Pam4HVjQWnJUlFb9ITohUo3ooKnZi4jqWSRHtkT
 Q9ATTwgPvPmSWbdttSl4onHp+7/vQ5OBTcYYzRGMTZc3DZMZjTk+yOr54UNpfi3ZFG5oOqQEArr
 b014V/gACuL0phy96uMe8xEhBuvcM/RZ6RAl68Y9S7Bnzy9h7pa9KVrNIO1lZ+vqTBMFrSX/F9E
 KCv0Oz/f3s4Z/XDzlTzRr3i9OTC5IYi9DVsAYtvG5nvnhvHvAw7xMTmMu4fR55/QdmtM8YJDAzO
 /lcfzCMFiwcWGIA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 23 Sep 2026 21:25:19 -0400, Stefan Berger <stefanb@linux.ibm.com> wrote:
> Reject a response from the TPM emulator whose size field indicates that the
> response is smaller than the size of the header.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


