Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EACE6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDaf-0004fb-4L; Thu, 21 Nov 2024 15:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDab-0004Z0-SK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:15:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDaZ-0004Ad-N4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:15:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3825c05cc90so685167f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220142; x=1732824942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mrCW+//xou0Dlae3M7RmBbXAaIHLgsTUjdM/ZG0Om/U=;
 b=y5icgU4b405lOb1diRziF0RygKMLWFfV2i5HTZvj4jQWWvU3FD15NK6nWiGdf+O0zW
 ns4Vlj+l/F9mtd8fAbJpPiJ1rmiJKZ+zcBIGvkyFvzt/sya3/+gXTMvqk7hhUrm+JRrE
 tED+DZnDRv5nr7JSTVxl91NAdGInqYZtJtXtnousnUktSTQliV8a7r/JnTg9Wwrwe5ML
 0ziD6V8BANBFvSzdvkyFTWvyopOwxff32bv2WzEIN2t0CHmM/TOw712Aon6pAao+rc+6
 cXgv5Jv+nLaNL09yALcSYJM4a7fIw9BN0wP7vFxXDoiwbvsQf42Tl6Rgkit5J0jHOplC
 DJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220142; x=1732824942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrCW+//xou0Dlae3M7RmBbXAaIHLgsTUjdM/ZG0Om/U=;
 b=Owd1TXv6ZZ8Fo0YRVv6tFqa+ZLNahw1I22sl9b586lAkdAn58BZO4Bp3C6LVQK8S3G
 uox+oeSG5YLcmyE0oJW2moMzaebo5zdZZbo+9S2T710JuF+mbRV3IS6Qz5QRcLPXxWR1
 p5wHhKcZENvZuHTVyXtCTB2NIiOOeaLos8gY37LYMxyXQ7A939eLjSRSZyfKX//CyVIR
 aM8rX/XG3J3vXd7RayFSgwxi+sVS2TXWv2uM4dcLy/6WONiVAQVRSzSfcs1bWQMPd8r+
 BALxY+D1oaLHq1+wLA2RZfPrs/YhA4sfpiH2F7Yg6752Gl9rro425Mp3491J3V+cMpAF
 VAdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMqoZeBse7JXL/2nucm7jj25I3Fy1y7W73BXVsyM/PKt0hyfZoabPDS6Ta2gDEJHNIOdmrnGeB2Xdg@nongnu.org
X-Gm-Message-State: AOJu0Ywn0bdzFmfP0N7WVCyg8dqPziElb/pyx2An/xznBoYo0Fc3gcFq
 fITAe1Emjb9uZHlr/hoMMPUnVENGqaiuYT5sayODQDs8U051+x/ntBL8kvseYN8=
X-Gm-Gg: ASbGnctcPo0mvKNfnUyi7P7IJIeo+DM+KPQpd1vhD0PyZS3ZShX/2wXct15RApYji7L
 1jDilue+EKbnH2FFnrP6ngJj+U1AChB4l9Ab/6lU8SQrUG/KIfvRhcgvlIokDi47HjKp0ITrzl8
 n+jwAE9zKbGGjUUjHKjzaMOvi0W2DHg8kWTAKCdPPqLCvP1Ep/VY3Uv08eXavUJe2pxLZhlBCbf
 7dfETGbr0tUqUg1rX4JZ+bGEBbCg0Y9p7zvSdfHnMuBr+WUmpZQEulrqHdZxC+A+820
X-Google-Smtp-Source: AGHT+IEHz2icJAo2YCVMcYyeXZ4qp0we5oHQMuPEkG2+fyUEaPIZfh28rcVlp0QwyvimOUj4DD63fQ==
X-Received: by 2002:a05:6000:2b01:b0:382:4a87:6680 with SMTP id
 ffacd0b85a97d-38260b48616mr233877f8f.6.1732220141811; 
 Thu, 21 Nov 2024 12:15:41 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedad6sm435809f8f.91.2024.11.21.12.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:15:41 -0800 (PST)
Message-ID: <f084679e-a203-49bb-aa5f-4e3af3d1ac60@linaro.org>
Date: Thu, 21 Nov 2024 21:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] qom: Use object_get_container()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-13-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-13-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/11/24 20:22, Peter Xu wrote:
> Use object_get_container() whenever applicable across the tree.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   backends/cryptodev.c | 4 ++--
>   chardev/char.c       | 2 +-
>   qom/object.c         | 2 +-
>   scsi/pr-manager.c    | 4 ++--
>   ui/console.c         | 2 +-
>   ui/dbus-chardev.c    | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)


> diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
> index fb5fc29730..1977d99ce0 100644
> --- a/scsi/pr-manager.c
> +++ b/scsi/pr-manager.c
> @@ -21,7 +21,7 @@
>   #include "qemu/module.h"
>   #include "qapi/qapi-commands-block.h"
>   
> -#define PR_MANAGER_PATH     "/objects"
> +#define PR_MANAGER_PATH     "objects"

We can probably inline this string, since the definition isn't
really useful (and match the other uses). Anyway,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>   typedef struct PRManagerData {
>       PRManager *pr_mgr;
> @@ -135,7 +135,7 @@ PRManagerInfoList *qmp_query_pr_managers(Error **errp)
>   {
>       PRManagerInfoList *head = NULL;
>       PRManagerInfoList **prev = &head;
> -    Object *container = container_get(object_get_root(), PR_MANAGER_PATH);
> +    Object *container = object_get_container(PR_MANAGER_PATH);
>   
>       object_child_foreach(container, query_one_pr_manager, &prev);
>       return head;


