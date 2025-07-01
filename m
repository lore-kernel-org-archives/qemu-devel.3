Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E8FC8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHD-0001OZ-R4; Tue, 01 Jul 2025 10:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcGW-0007zo-0R
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcGQ-0007ZH-AK
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751381233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcCl2zKPwLM0dlrwgKKQgOls8JVj0FnXSi+h4nFbd3M=;
 b=NGAjuQGQc34X1f9YtjiQHIuAYi7dSoYmfyNKGLz/HudFUIimI9sNSgOzvYfCbSaRLtDV9m
 U7ap/3UmNqLlUo1rYmbOVyNLHnwcxDU7Y98FkaLTRcXiXtxhgJRkdVNd5xYwFMFHqGUlfZ
 GlzkYY63tffDE4zgQX+eas57KdMsuy4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-01QxhRiPM5-abPfAcY4VXg-1; Tue, 01 Jul 2025 10:47:12 -0400
X-MC-Unique: 01QxhRiPM5-abPfAcY4VXg-1
X-Mimecast-MFC-AGG-ID: 01QxhRiPM5-abPfAcY4VXg_1751381231
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so2356473f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381231; x=1751986031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vcCl2zKPwLM0dlrwgKKQgOls8JVj0FnXSi+h4nFbd3M=;
 b=DosEnafQ7OP9mQ/9wbduhi+iOtkqaYf23ubdgr+YFEXLif0xjqUdszTLJ/LJpu/ViR
 HxPoZ2MZX3N78Y4dZH1oDfPo42eYL3GA1xAupGygKXFgsb2f2Lk0eVeSNHE6jfwqiC3/
 ZlWuOnMG1AccXp9y93Kx4mxW6gpFsPnIH5iJzyk1ffSBlAliGWy2LzAObCd9Xo62WSTp
 fbSYtnQRTlFhsdP29a8kav+JGWxK/QiRvsIvADQPdvv57mxFQ9u0Mg6bKcSnDCN2qrXd
 nt+KHXuo8vPC1iyElnix89Sg7p6xqMXcmzJ+kabIsOmbl4cl/mJ6ToG4qo4G1g2LI2KG
 Nq6g==
X-Gm-Message-State: AOJu0YxlnchUWJWtJDibhL77XQOC580h8Xlec3BOvCDlkS8QosWiSIuc
 8W0y6zw5Js/dbM7VKEplQuG4Q9JEDV8A/4iGS1wtQy+F1bPfmQwk6oSbpaEZDw1ChrhQdonwlXK
 1DT+klhdk61AsGrZTdz7vveTq5zThCRqESRdAEoR6GkMoz0pZHMxfTpU+
X-Gm-Gg: ASbGnct7BcYH/jxitZGL87DIw8iALaGdJUFlT0CTYuZ2123hYPHCyRmRrD6p79LwOof
 m2I2tD/IoJv/ybqE7PfT7EuVv9PI6W20jSmopVSBnrWq7HcUbhRpFPyIEzOH614Rs92O1bM+Neb
 6enN0ZYPUvmKDNsa58ccey96C/kq9RGVq01hYSGGFjnzXI8QcISmF/Ngr5squ1fEcupkdfyrQOK
 fDQ3F+lFbpSu3zNPF0Jl11uSuBel8w5URZuiJyXSPCv5PGtCqhlL5bUFGzCwhoVySJoTYPvHqdB
 Fn4OI6Vq9ckp/NHyXd0Uq53VI1d7/O15AOs/7A6GeaGxU8V2oFjSWOM9ip5zPvs8sulibzNOl1H
 rmLPK8PxK6vunrvgFZqcXfkImFJWWW5DXUbGT+thA06tNs2P5fog=
X-Received: by 2002:a05:6000:42c8:b0:3a4:f70d:a65e with SMTP id
 ffacd0b85a97d-3a8fdff47b8mr10244002f8f.37.1751381230673; 
 Tue, 01 Jul 2025 07:47:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD/WvDSXzjXJRmmakKUJ3u/6lYBPxmNOoFf+q5BYaMWRA5vuSg60nG8+FGoNqtw0uC04bO8w==
X-Received: by 2002:a05:6000:42c8:b0:3a4:f70d:a65e with SMTP id
 ffacd0b85a97d-3a8fdff47b8mr10243978f8f.37.1751381230220; 
 Tue, 01 Jul 2025 07:47:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f3aa:cbe1:b363:ae39:fc99?
 (p200300cfd700f3aacbe1b363ae39fc99.dip0.t-ipconnect.de.
 [2003:cf:d700:f3aa:cbe1:b363:ae39:fc99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8a0sm13657066f8f.96.2025.07.01.07.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 07:47:09 -0700 (PDT)
Message-ID: <fe18dfa9-c949-47a3-a67b-b49631eb5fc0@redhat.com>
Date: Tue, 1 Jul 2025 16:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] include/block/block_int-common: document when resize
 callback is used
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 fam@euphon.net
References: <20250630113035.820557-1-f.ebner@proxmox.com>
 <20250630113035.820557-2-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250630113035.820557-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30.06.25 13:27, Fiona Ebner wrote:
> The 'resize' callback is only called by bdrv_parent_cb_resize() which
> is only called by bdrv_co_write_req_finish() to notify the parent(s)
> that the child was resized.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   include/block/block_int-common.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


