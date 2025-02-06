Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA7C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgAZZ-0008Dj-AL; Thu, 06 Feb 2025 17:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAZX-0008DJ-M9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:42:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAZU-0002uJ-VH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738881725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=At1cjzSc+MFqeYl6Dpt8v4mTIuc9DPU3kGWKLkuRVZ8=;
 b=cGZBx9Opj3eK6H1sY761leiRS3nL7EDKnR0H9UhGpvMoE8aAXaxPAegWGeDG8LkdzPRKOC
 /yDPECwR31ElthLfeuPRQf+5r9x6ebZ2bk9Y2nbyIIX6lURlfghYTbPhYELK19ziyUwzbX
 HFFX/ayjMA/a/IBuEmVLkURLwsZPtdE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-kH3xFnK2PY6p_ZnIc_vzGA-1; Thu, 06 Feb 2025 17:42:01 -0500
X-MC-Unique: kH3xFnK2PY6p_ZnIc_vzGA-1
X-Mimecast-MFC-AGG-ID: kH3xFnK2PY6p_ZnIc_vzGA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e425770413so29216086d6.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881721; x=1739486521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=At1cjzSc+MFqeYl6Dpt8v4mTIuc9DPU3kGWKLkuRVZ8=;
 b=QBk3k+gnrOT6twN8kE1qUy/ImSesDkmr0KjWryHYsoTQT92glUT7LmgvEPurY9wG6e
 tumnCMMbvLfR0o3LumHB/UBJoAI6a8V6VBEdy7VSDDRbdjDih9epEsF5PcWCuH6LGqQY
 G4atXa9PJfG/UNxagY/xWQI+0AN6RbLCRfLd4moPDOGiO5KHKUg0AO8kLRjV2/5hDUXz
 +CdLiQKBpZWKZ/x0qI2prSKNnjYNc308zxKQhJbKwO2r12nkMFgSd//KqlldPQfGLzS1
 QYn5RPEZJ/bY6aluVcka58d5KZ8der6d5RfbxTSkt8ni99wqm6KlF9njGyp6HHQ5kLqP
 t3kw==
X-Gm-Message-State: AOJu0YwgIu63zsAFeHTx2jg9zZJDiKWdeW+KVjzTM2O/GdMYRqTdeFYr
 tQwjZqvLOXEsNpKxqSPofhAHjzkPdy6MCAecSnS72+3yZ8/MtTyLbGBkvylo9fqno0mWj7TRw61
 VyaJFXi5PtdX3G3DMN1lNjqLdGZBFWO+xTNz+Xx1+9tvFxh86uNzq
X-Gm-Gg: ASbGnctG8GF4Ccz5uUzCpN7DU5n37myLF9H52zNteX0y9vLMEtUoxI6KIOs0EIuaByc
 L8lttfUo3fkC7Gt4eWPUVSmxgsJU7pTelgXzPthB+ssyWCr83O8YhxmpPLacLQcVFUByQJ9GeEx
 iUI+6jMyT6OJtxAHMNrJLehouuw0Nr7VQQL553s+cEh6MZ6+ebqGtRb7pDoEMIVPhb0R3jzXFYv
 VRVlQ415Cb8yPbYj3luDKavGFKvpBvndMnsHqXR8MSboRSGSBGxSghO0o21X3VdAo32jmMPRpT1
 U9PYdMMXds9yvoSrfWM3YsrLI3PEM2Vyrt5MgOtWRyknLCyr
X-Received: by 2002:ad4:5fca:0:b0:6e2:117d:e67 with SMTP id
 6a1803df08f44-6e4455f1f18mr11090066d6.14.1738881721149; 
 Thu, 06 Feb 2025 14:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG93JvtF13nm2n13WAu0zFV0sQ7aqO1tz2UZU4/qVyj2XfzDD3qBJdiq0LmIBjgQKouWcFVNA==
X-Received: by 2002:ad4:5fca:0:b0:6e2:117d:e67 with SMTP id
 6a1803df08f44-6e4455f1f18mr11089916d6.14.1738881720917; 
 Thu, 06 Feb 2025 14:42:00 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e44194ac0asm5508426d6.117.2025.02.06.14.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:42:00 -0800 (PST)
Date: Thu, 6 Feb 2025 17:41:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 1/5] migration/multifd: move macros to multifd header
Message-ID: <Z6U6t_IyL4fQ3M5z@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205122712.229151-2-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 05, 2025 at 05:57:08PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Move MULTIFD_ macros to the header file so that
> they are accessible from other source files.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


