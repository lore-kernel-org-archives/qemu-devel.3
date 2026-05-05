Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A912CD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK94r-0002Dh-90; Tue, 05 May 2026 02:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wK94i-0002AC-A8
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wK94g-0001wN-I2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777961765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znPEUA4eUm4VBJWFHc8rFGXpcOdNj+vW+vCs3gu9GV0=;
 b=ZvhA9lUrO397oT+Oy2mRC1TOZljxBISVHmnLJ4O8aWZv8ZejBjWSfkAfkY6o2B7qpm5H15
 94AmM6ECbfaAb06qEdBEGVxGGHtY8BDRSxGeN8R78CPcedJzHxw2HA7j+HZs9SDINYmmKD
 59Mr/O7jfYHoM+HShd80J2jOKoghgTM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-8wrtU7bQP62nggBVSPiQKQ-1; Tue,
 05 May 2026 02:16:03 -0400
X-MC-Unique: 8wrtU7bQP62nggBVSPiQKQ-1
X-Mimecast-MFC-AGG-ID: 8wrtU7bQP62nggBVSPiQKQ_1777961762
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B5991800348; Tue,  5 May 2026 06:16:01 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D31330001A1; Tue,  5 May 2026 06:15:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 6/6] hw/tpm: Add support for VM migration with TPM
 CRB chunking
From: marcandre.lureau@redhat.com
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com, 
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20260504174234.13556-7-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
 <20260504174234.13556-7-armenon@redhat.com>
Date: Tue, 05 May 2026 10:15:40 +0400
Message-Id: <177796174024.65777.16091797420862658987.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=832;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4IDnlcxVk1lMpvaM3EqrC0SR9wa6qjqL/re+oJLxDI0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+YsOv1ABMHlXi7+5KZk3N+gN363x0CBE2uv5h
 KQYoPoaq7yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafmLDgAKCRDa6OEJdZac
 5aDrEAC1tzjauOwiu3h14O+FBcPzBUlHPYtpEnVacgGR9bGvxjP+itvazm9Fz7NpGuDhku/ve8P
 maRE/XmWL95p46U1R7nQW4uR4HtuLVly3Aw8s+IkKPOGXgL4ZQcVIZmpp+Q0ge4fR/D+WvjgtJq
 SAg73QCF2bM2x/vp+eFZmRi8TM2phWxxHt40YlQ1hhqSk9J15eitcGeyj3r6lH7gyqZAqVgWGT+
 QNB8Cdmv7NxLmPYQwbxjUC0CE52YUClgedNCcPGOF+elo282in03n5uxMWK4cVHFVfev/yXxTJJ
 l2y3y+CsJ3L40Nn5ztUWGShp/VIBIX8072dYqmctIUzVGbXbfzp2zRrUGqeHwI4zQMqKJiBF8FW
 p7hEut3wDE/CYbstWjwhdyVNiGuFEXS3vmE9amlCRmBVT+EP20gaksCSJIG7btB/DoktHY45zDj
 IgEyz7hq5PX8CU4ZjTuQGSlWrzgDOlPzzh7amsnFM3ZBjlJR0Vu35XNy5VwRDxeKuOdjS+Ec94h
 HwVsINI9CDJv0/wixfo2cxZzy3GZLsZ2b7gU4i43UM04cUle3uOaVtWO02mRA2xJGTWtMl30hsJ
 EvjMm1d579pMG3wLyBvxhnoE2TWbXa6+2T1oZXKuGPXoqYOkP6gvCaMoyFrGyRj0440LKlSgsbc
 jcWgS0T+CVOOEGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 04 May 2026 23:12:34 +0530, Arun Menon <armenon@redhat.com> wrote:
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 5572d892686..98feb734d54 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -457,6 +520,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
>  
>      g_clear_pointer(&s->command_buffer, g_byte_array_unref);
>      g_clear_pointer(&s->response_buffer, g_byte_array_unref);
> +
> +    if (s->migration_blocker) {
> +        migrate_del_blocker(&s->migration_blocker);
> +        error_free(s->migration_blocker);

migrate_del_blocker() already calls error_free(*reasonp) and sets
*reasonp to NULL. Drop it.

Typo: "be_bufer_size" should be "be_buffer_size".

Typo: "be_bufer_size" should be "be_buffer_size".

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


