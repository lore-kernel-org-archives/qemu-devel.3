Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78811C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRnY-0002yB-UY; Wed, 27 Mar 2024 07:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpRnW-0002xh-K5
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:50:26 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpRnV-00050D-8M
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:50:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56c36f8f932so1423696a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711540223; x=1712145023; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4FC6f2CiQL5W1YZBJ6SK7a0UwL0NwwFJDhTY6Z9yEh8=;
 b=KHOKffMR8YGiZteyGdZMIQPlHKrZOEQ6AAuC9yQxVZeT2cWihimqAziYMc/VNaofMI
 hKA4Y0g738Rs2EWpVFKWYtBpcU3aw/f2LNsgvcqmfoH6dX4H3bX3BEU0bUCBDucCT363
 aZzC793g28NJBinXT8LLj2m78G8e328j0rliM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711540223; x=1712145023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FC6f2CiQL5W1YZBJ6SK7a0UwL0NwwFJDhTY6Z9yEh8=;
 b=JddAiWkB4k1x6YcEUHFUpp06Nn/3jfNFsiLU3Y7sGbqzeXbnEYztgVVhLAYFobEpbo
 BjYqjRn3b9a5f6fIOffN15I/Honn/40kQo2zzf4+ocxXTE2jZokBAgjKCe5WJm0kzfFB
 jpx0uaFlBJ7q+Z/hJhPeLBU0w7MsZ/+veYH8hzsgju7NcGYUse1XVzOAqA/YLl8RaWbI
 bRDkxPeF3ew1ktV79zLWql5Hk9vDnQ1HZE38HXgWdeWAv/Ep1NhszRVTDROAQyGDmdRU
 vxr2wD3BTsox0EFWJnpg2JD6aZXxd4bmg/R8GAlKW6mFZmWhceptSVrHjP0GF4OPRKxo
 XU1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpTMtYUDHMgr6SGskrkCYgPjuS6ZGc/2CpMw0rRB/ny27VdmjkusAygGLprhAZFqXV/hdXhRL5/iECeUtLPSAJMe3tckw=
X-Gm-Message-State: AOJu0YxNAheXwGdfHGrVdzQ0QJ54TQtHPByXp7KQ+zYmhsnETfoeW8hC
 fi6PCqBxigL580nBZScISaRxYnclDTi6t1EA13Qp6gqDNRmHgmloaMC5vGrnqdM=
X-Google-Smtp-Source: AGHT+IHjrlueyINri3BcwMN7nzklq3D6QJVA6wmS9ETMB5MPCffXe1tqgCTZZJIf53/O2Hw5bsVZmw==
X-Received: by 2002:a17:906:a890:b0:a47:134d:2fc8 with SMTP id
 ha16-20020a170906a89000b00a47134d2fc8mr3629567ejb.10.1711540223416; 
 Wed, 27 Mar 2024 04:50:23 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 u1-20020a1709063b8100b00a46fbff47a6sm5322360ejf.168.2024.03.27.04.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 04:50:22 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:50:21 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 05/19] hw/display: Restrict
 xen_register_framebuffer() call to Xen
Message-ID: <7e08a2d5-7d90-4d48-85e5-4c7e39d59c11@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-6-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=anthony.perard@cloud.com; helo=mail-ed1-x531.google.com
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

On Tue, Nov 14, 2023 at 03:38:01PM +0100, Philippe Mathieu-Daudé wrote:
> Only call xen_register_framebuffer() when Xen is enabled.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I don't think this patch is very useful but it's fine, so:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

