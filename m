Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB22E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sme38-0004aI-IK; Fri, 06 Sep 2024 14:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1sme36-0004Zh-UC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:51:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1sme33-0000wx-UI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:51:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-206bd1c6ccdso23604005ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725648667; x=1726253467; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kChTinXf4u3o2MqbwE22lDdL06wY/scU/J4lQzAnx2k=;
 b=B+FDLAOE8I764qVPMsdIDXirH8SDtCcuMdNkHwx+DmaHIhJfkHNwLwGUqCIchXrtai
 HcYtFW+6zLmx7ca8ZA3ycEphk1vlP1KIiSZJDuhFcDYugfs4ib0uKPvpdy1BfsHvbO/+
 bizgc571hLMY7Qm5dY64wEY5dJrcg0byBGXNqZgLS7Fk+8v7864FTICOFfij/5p6iBu2
 ma/FR9fJ8jykbn6LRaoYwubSIx0ruHCCIWViPqWlVeQHFcyGf3yxdO1Apoyc6QxO4YWU
 fWjh9UlhqSvdVAKh1RWkVNoEvmAk51gLCvSP0agDyIim3MhzzAAp48uzu7Te9la4jQFb
 LrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725648667; x=1726253467;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kChTinXf4u3o2MqbwE22lDdL06wY/scU/J4lQzAnx2k=;
 b=WL4jQxIX0yLChJbJI9muH5Ta8N1q3ktWK+cl4wCMzE6PSudbj9wYdidAjz642y3AuC
 oZxGzEltqJDLz7HHKTrnGcoYRHZtCrIDD60czTo6m0Wm+aKhW5n3wvK+6XYSwUq40cNx
 zdjF9Y/U849rhKx5vcZzroRRHws3Pu1kCoaWfKUXR96crVVpugfej5XQbX95DdxgGmLI
 n8im0ez4jp86dvWiJnQOXruudouIV0YNSLTEOCHkjHUEmNhZZ9z/ITVizVrxNtX9ONZh
 3rLZ2iCWuSp6gAqO0pG4VGS0remWfOErMPwWJzFyIWcSzYMTnPnsxGEzCOwkQ5IQMniA
 AFBg==
X-Gm-Message-State: AOJu0YxcCxBcnUD0IjMFu0Po8PwYyHMfiktld+hJTJ/0JvHJCZxb/5Vl
 akxc01DXGuYRGTG6NVFKLkNxqQ3GvQp/o180IKoGmYEMdSr2PA+F
X-Google-Smtp-Source: AGHT+IGWdps9VaAh+oF7tc/eSAl4HxtO3JzZVc7cJTqWPOt4IVuQ2g073mV+1ZsphkHf4pwlk7L8xw==
X-Received: by 2002:a17:902:da82:b0:205:7cae:4d29 with SMTP id
 d9443c01a7336-206f05f675cmr48127865ad.48.1725648666948; 
 Fri, 06 Sep 2024 11:51:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea66000sm45787825ad.276.2024.09.06.11.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:51:06 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:51:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 3/5] hw/sensor/tmp105: Pass 'oneshot' argument to
 tmp105_alarm_update()
Message-ID: <2d5e6096-ee8a-44c6-9d8b-e80f4697ccd0@roeck-us.net>
References: <20240906154911.86803-1-philmd@linaro.org>
 <20240906154911.86803-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906154911.86803-4-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 06, 2024 at 05:49:09PM +0200, Philippe Mathieu-Daudé wrote:
> The next commit will clear the ONE_SHOT bit in the WRITE
> path (to keep the READ path trivial). As a preliminary step,
> pass the 'oneshot' value as argument to tmp105_alarm_update().
> No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

