Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78572C5DF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQKG-0001fY-5N; Tue, 18 Aug 2026 16:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQKE-0001fA-Ek
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQKD-0001YT-1w
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImMzd/CVxkW1LxVYTu03h7u30z5ZwSTt6inRaT8mj80=;
 b=gVVKv8ECfkgcYr9vUDi4HS5f+IMckPAS4hSXHpxVP1XEhuDfuk5mLcAqK56TMl1xbmYupA
 +58yRXvaHfY4uTbP6jCB9QIQT7FnVNy6NE+UYM94RHC6XNXgEn9unCJVqH9ht2ZSakUiV6
 cyoBNXonLKC7PM/iDDQ8FT1FRb8ipa0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-zPJuPG2RM_60FMzcYdHwsg-1; Tue,
 18 Aug 2026 16:22:07 -0400
X-MC-Unique: zPJuPG2RM_60FMzcYdHwsg-1
X-Mimecast-MFC-AGG-ID: zPJuPG2RM_60FMzcYdHwsg_1787084527
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF8AE195604C; Tue, 18 Aug 2026 20:22:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26679195608A; Tue, 18 Aug 2026 20:22:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 06/32] system: check security for machine types
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20250926140144.1998694-7-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-7-berrange@redhat.com>
Date: Wed, 19 Aug 2026 00:21:49 +0400
Message-Id: <178708450916.1320462.5283210372449603542.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oect2DcMrHvV8w+BE6qUoO5yYGDL+AWpCFgUoOqX2hg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhL7f8OUZw7SuKwSWSaNve6n8Xhoeb9rAfHdTR
 7v4o/Mnu8WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoS+3wAKCRDa6OEJdZac
 5SwzEACUonSTrrz4MDQPrhoBujRR199aqgJmLzRC8eUXNlLwdMD2unyI6bLgeUK0k0a+r+cXq0g
 0jqiwJlivb0iMOwoQYYpn6zJgXE5S09VdiQI4ifKlmaBhCGmWkMWAijDUaGu1dupxIGrugZ/wk/
 dQBLD49KNa8Xrqb+4j3sWTwpbvEqdzs5jCo9WzDPeLZAeC0k5so6VLLIoEpmwHHjl5WgDwvCeIR
 7i8qS5SM1LjHaJ00nq37lEGdTbv63RuiUKWQs7LWOEhblAcjzqNR5Un99La3JXaqTJ7+tlfnTYi
 ZeMZKY3JkoNSwEs9rv2V87qFlR0v6hlQ97tD+j35EebBQNbI8XkM0ByaebCFDKLAzpsImRBUQ9q
 pf/FjaSCUyqC4MI1LbJee74lSuCMkpEnaR1YaDZvr+0MrdxzsHvvoHhz40U4MzjI6OPW4swA3jI
 79TWG59KKC67W1Nm/rGI++bRXNrs6pPt/dRXqMhZ/zvdW4NdpOmbSHFFS5Zi/1OTKdX8qUY/6Qh
 +yKuy8hg/XYOR7CeHAHNT6CqiKIXXpiuNlAL4AS3s1IaDTcYBnJpumuZ2wQ5Hg8vS5q6QQhHSdT
 30hY+i5Dxab/i5bUQr4DBi1QEivdyyEbVrBe6CxAI3gI4ToBIfzqAtQpATIjTLK7tKVp3qhdE/m
 98C63ijOmwLR7eg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

> This wires up the machine creation code to apply the compat policy
> security check.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20250926140144.1998694-7-berrange@redhat.com>
>
> diff --git a/system/vl.c b/system/vl.c
> index 38c6caf52467..716bf6d490a7 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2182,10 +2182,19 @@ static void qemu_create_machine_containers(Object *machine)
>      }
>  }
>  
> -static void qemu_create_machine(QDict *qdict)
> +static int qemu_create_machine(QDict *qdict)


>  {
>      MachineClass *machine_class = select_machine(qdict, &error_fatal);
>      object_set_machine_compat_props(machine_class->compat_props);
> +    Error *local_err;

Move local_err decl one line before, and initialize it to NULL.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


