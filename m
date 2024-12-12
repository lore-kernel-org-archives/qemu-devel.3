Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2866E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlt6-0006gh-Fj; Thu, 12 Dec 2024 11:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLlsz-0006eh-QJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLlsx-0006eB-I4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734020273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCFlWWJpb6Eqwm/ohZNhVceFaUlNcCtKJacg7HQwSU0=;
 b=Irozi+cbJG+9Jk8IshdpOXgiYqauZ+MPDYSxzZs1K3C/+bqegPJ+LRe4sf7xPcsZ9JPcaq
 A3j/RElkJQ2hmRtAdNKr+B5VUeIpWNF/5jz4F7exUf+vh4Gp1KXpzgkwOHlYbzozmI16RX
 UDAOqZXFnlCGuG8Qro8rVedQBhJxVaU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-VWfHT2d1NniY5eo_F8NrhQ-1; Thu, 12 Dec 2024 11:17:52 -0500
X-MC-Unique: VWfHT2d1NniY5eo_F8NrhQ-1
X-Mimecast-MFC-AGG-ID: VWfHT2d1NniY5eo_F8NrhQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46791423fc9so16651311cf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734020271; x=1734625071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCFlWWJpb6Eqwm/ohZNhVceFaUlNcCtKJacg7HQwSU0=;
 b=aMFTt+jjHuTOKVPUBzuaK9ii7XJAk2iNLdthoWbuxdJR7oBOG7H/7dwLwGgM+ob2lE
 YEXgnsTRnjh6nMRkHNw04UB5UzszfpCEJ/AXWhTH928Gf8RMk1UB+q4dDdLKup2/UlI9
 WgbsOGs0bMRjZuVNW18mPdwUXVVTHJ0cP8C9jr7601mdVHEd6S1O5JW2VWjUZtONad92
 gND5xb0BUZ28D5F6IVO+gtIEoM8+YjAQmEZZDIYC7LEagfmI0xD4bkIz6EqyfY1Aqbht
 mR8NzzbchNOBmsAp+4ySNkj7SMR9z2QZd0647FRgcVCyLRo9kb/EVwvSyikHUzbiXC9f
 +wmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6nzvphDF0ohOJMFUZwmAEIjlKxP6z12/Fr36eakJ29RlQYLrKIdkqriOi7mcf5wp+4/10FBad3/+J@nongnu.org
X-Gm-Message-State: AOJu0YzQFmGqjPaI6sjrtdGKNG43QwW67/Tkem0jZCHHWzdxFTBguPII
 fdILi6S5sKiObFLG9KbTfgYjGb1uI7NB/5DkTXJMhocQ+VW2awDoYmXd0MGzNS2NbvNmcW6TgR5
 v4EOOPj9ktwF7bOBC4S36GyB8gI9E2wbg15fkLI+baDBFW2v34Ggn
X-Gm-Gg: ASbGncuwwOb7urPKr4ScilR7sQz6qZawzDXTJkuLU/k9PAynC7plPRJR/69xGmPjwrw
 RNE5XwFDxsFgQgoiA7ibmaTcoo++41gHLSwF5KoU5qNPkYHK5carGQqlD6KL/qBuhvh+OphfvgS
 39y+IqIhFCxPSPBVeBTvTR+8+HRAWK73bj7J9rOP1CkCcbn8gsvtw29jzKmlWsjckL2lUOhvztD
 YXTCEVcXUy8I/e9VD0RLfSPKyj5RzieCVmw2FmPO1RxKmJBLOsYqrv4XGfHEo6UC6AvEQk+LLdx
 K3srQCaX+mFsSbZlHg==
X-Received: by 2002:a05:622a:120e:b0:467:67d3:7c8f with SMTP id
 d75a77b69052e-467a1524380mr15284661cf.21.1734020271570; 
 Thu, 12 Dec 2024 08:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmQDuV3LMe7JmvWfW9GiwwrRDQnhMwpWW3hG20WYTuwNGoa00CdLHCsHsNmqfEMXh0IiGgsg==
X-Received: by 2002:a05:622a:120e:b0:467:67d3:7c8f with SMTP id
 d75a77b69052e-467a1524380mr15284341cf.21.1734020271313; 
 Thu, 12 Dec 2024 08:17:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46761bd6547sm47537061cf.77.2024.12.12.08.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:17:50 -0800 (PST)
Date: Thu, 12 Dec 2024 11:17:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/4] system/vl: extract overcommit option parsing into
 a helper
Message-ID: <Z1sMrUbvdHOd6Pok@x1n>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
 <20241211230433.1371327-3-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211230433.1371327-3-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 02:04:31AM +0300, Daniil Tatianin wrote:
> This will be extended in the future commits, let's move it out of line
> right away so that it's easier to read.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


