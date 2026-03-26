Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEEE10A1E68
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5irx-0005Nz-2A; Thu, 26 Mar 2026 07:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5irv-0005Nh-H3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5irt-00039S-JB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774524434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WagbU0zByhe4obuiYslSucFX597WIi4UjIywyFUIOc=;
 b=A75SRYtEPNCpsF9AGoylrZmMi0/UTMLJSLSAeNX+bTUVLRcF9XB0sWiv/WGbSzA9keuDMr
 xa2Jdzpoe5LgXN24vCINUsnR7jc6NB5waEn4V7NuZQ1su1Sbd94lU+uv8L40YcpUpv46Su
 MR9iUOUqrFM/DVJYmhSGArgN0VsRtg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-0_QNjDnnNAiX0hDriw0azA-1; Thu,
 26 Mar 2026 07:27:13 -0400
X-MC-Unique: 0_QNjDnnNAiX0hDriw0azA-1
X-Mimecast-MFC-AGG-ID: 0_QNjDnnNAiX0hDriw0azA_1774524431
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4E41956062; Thu, 26 Mar 2026 11:27:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66E761955D84; Thu, 26 Mar 2026 11:27:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC v2 3/7] hw/tpm: Add internal buffer state for chunking
From: marcandre.lureau@redhat.com
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
In-Reply-To: <20260319135316.37412-4-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-4-armenon@redhat.com>
Date: Thu, 26 Mar 2026 15:27:02 +0400
Message-Id: <177452442284.34609.15714360618166734027.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=975;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p7LaWUX9Szh9JJaL3chQjl3jm02DQTsOxAyQHXGb4dw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpxRgJsr5SRU6fSsqadeluL07BB+vAiBlcLRr7f
 utaHKfGW6uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacUYCQAKCRDa6OEJdZac
 5aUDEACIPhW9ySEZUxwiMy+TUk95EaXOGxaHsNPHKG0NY/WY7Zm823pnDBtMwJWOGMWtwHDlgD+
 ccsH+MkODiGQfmmDtDqH8x6t8VjwEgYF3ufOk2mLHN6Bat28Reu21euWMogMn3N0Awx90lBMObw
 579DV24Tz3IO55HgINvd5tReUdZGhNYyEO7geKzzijhz7Vgh4boF2mNpxgLt15rzjnxTqNcNCIo
 +4MvHAR2dalKzz5SwLFLSF9qNvoCIX4bE2CopjE/6eFBnH0iL3+xISPGCH2wCWtLQsxYT6gd8cG
 8RkUH8HzDYhQ1x4IQjgbkGJ0CgYJ9H/w7nDpCPMVIeKr2mzCG69yKtwW3PnDUUs/C7ugHTw7J0b
 7VZMRRMBBFjDOcO6UQ7dgAnMzQej4JV6E5UL3r1PWULg1/NGd9qKIIm2ICrMvoyEF/lZ6x4dvra
 jS+dYvpDiPV1DZTUJqy2sOqXZpdk/1AsDDC65ZyYtFaPK9qx4KjOE89T6ul2Ce3Z/QXtvfHGCCh
 KrAnUXieeIUo/wPGG3CtFs+IEGRFsU2QBB/GwaiHoC2eNjjRgo4XmcBAv3xdRuMb611k4cZD7kC
 Us/Uf5UrPZRarcHIRGTmebwEG91jW9jPqOf38qDMS/BO6p0vChceYa7tJ1BqmR3ijzAm/Bp9MTq
 CXDAkxTTYBLAkrw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 19 Mar 2026 19:23:12 +0530, Arun Menon <armenon@redhat.com> wrote:

Hi

> - Introduce GByteArray buffers to hold the command request and response
>   data during chunked TPM CRB transactions.
> - Add helper function to clean them.
> 

I would introduce them where they are actually used, but ok

>
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index bc559087867..5ea1a4a9706 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -306,6 +319,9 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(get_system_memory(),
>          TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
>  
> +    s->command_buffer = g_byte_array_new();
> +    s->response_buffer = g_byte_array_new();

These buffers are allocated here but never freed. Please add an
unrealize or finalize handler that calls g_byte_array_unref() on
both buffers.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


