Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5187ED68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0Xm-0003fy-59; Fri, 15 Nov 2024 12:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0Xk-0003aD-JT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0Xj-0005Pv-5Q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731693337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a26qwpddi1QLJrKenqSdaW0Mj5SKv3E9JSrg4FAqSAM=;
 b=GWLV92e9lqKWuNut5d6l7OYIN36MJbiGCdnAjOALxr658Kzp18SJEW2fL7x0PTKyo2Ov35
 tSOXRlFvXvxRJ5hRI8CZDunwgI8ZCE81R6btjqqIHd8P1tNMNG4JfEzkastk/I6JFlMQpn
 SiM/tdRyNPgWjnodPBG5GH2wS1vBL7s=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-3D8atmR_MeqUbykBMSsCJg-1; Fri, 15 Nov 2024 12:55:33 -0500
X-MC-Unique: 3D8atmR_MeqUbykBMSsCJg-1
X-Mimecast-MFC-AGG-ID: 3D8atmR_MeqUbykBMSsCJg
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3a3cb771556so21280825ab.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693331; x=1732298131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a26qwpddi1QLJrKenqSdaW0Mj5SKv3E9JSrg4FAqSAM=;
 b=PGAsioDUE382/qtdNkR6tR76uqOSNAzqhCk7m4VK5uP+psykpulOFJQbnTqQk+NB03
 otOyl0nsTIDfdaA4CqOyIP5Aymu5YUBqPNDNhD7D5AT2QKXLSrq16ejNcZ21O9OCOMvQ
 +JOEM1lcAQIKsijzI7WrTRyugZ2J1xTmGBu7DDVugoxrm4RBQ/yvZQZQ1z5kX7wF/ujw
 no8lVgUhOJ5udjz+bxtbVwrxeKYCLq2UExMWvbr4W9n7Wx7AaOJTVESb74bjpBfRGgo+
 tuIrJ5w3eHQe4FFyYCRi/CQaM5ahu94AYCrjUHys9ebj0/bkF+DNp4Kx8SwmexW2+JnU
 EOzw==
X-Gm-Message-State: AOJu0YwNf16FVtAKY68vXAdoT2sh9ViPCeROBrgOXj+3OjL6oIowhSnp
 z4jUQr/Q85AuW1NS9EgWV079wEvMg/n0GlNHhfcbvUgqxdoH/HTlbDrEK5i7qhGmMq1mdAyPQuv
 B5N3RPZeanj6gXXeynozOF12mP3a2BiAUvyVm76jsmOYaolcds+ZQ
X-Received: by 2002:a05:6e02:214f:b0:3a7:159d:2dd8 with SMTP id
 e9e14a558f8ab-3a74801389bmr33748345ab.7.1731693331363; 
 Fri, 15 Nov 2024 09:55:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu+5PavVXELBAEana7IPzbowkTkOVV1bMP554wp2HtPMuuZ/kcw7F6ipXr9TjhfscXAAjO8Q==
X-Received: by 2002:a05:6e02:214f:b0:3a7:159d:2dd8 with SMTP id
 e9e14a558f8ab-3a74801389bmr33748185ab.7.1731693331028; 
 Fri, 15 Nov 2024 09:55:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a74808dc69sm4241575ab.36.2024.11.15.09.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 09:55:30 -0800 (PST)
Date: Fri, 15 Nov 2024 12:55:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 9/9] hw: enforce use of static, const string with
 qdev_new()
Message-ID: <ZzeLEJpx_Yg-LNwT@x1n>
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115172521.504102-10-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 15, 2024 at 05:25:21PM +0000, Daniel P. Berrangé wrote:
> Since qdev_new() will assert(), it should only be used in scenarios
> where the caller knows exactly what type it is asking to be created,
> and can thus be confident in avoiding abstract types.
> 
> Enforce this by using a macro wrapper which types to paste "" to the
> type name. This will generate a compile error if not passed a static
> const string, forcing callers to use qdev_new_dynamic() instead.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


