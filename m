Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91317CDB46B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 15:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waxWo-0005Xz-IX; Sat, 20 Jun 2026 11:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waxWk-0005Xl-UC
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 11:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waxWi-0002E5-Pl
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 11:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781968949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyNBENQ7plqOT9m3LCX8AfT9Cl4ojA3Hc06FGUff6TM=;
 b=DGvKloF/ys5djvgQ/hnCDGo4mZfPn6kE/rEHKkNhtxcBrduq28lvAUiEzW+CGJqiQri2gF
 JVJiwAUaEP7rm9u0RLvRN6tOfIQ1kgGgow4DM8WXmNv4WUogGSYAI5chxfxeD66xbpQOYz
 i60XcbwoFifLSlPhULGw30/u6tlAqGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-qiidXEn5NkeRjGBMkvT1jA-1; Sat, 20 Jun 2026 11:22:28 -0400
X-MC-Unique: qiidXEn5NkeRjGBMkvT1jA-1
X-Mimecast-MFC-AGG-ID: qiidXEn5NkeRjGBMkvT1jA_1781968947
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b9cd54f3so18870375e9.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781968946; x=1782573746; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uyNBENQ7plqOT9m3LCX8AfT9Cl4ojA3Hc06FGUff6TM=;
 b=QemSG1C7LcnO16YfRJplsbyd1sE6vZ5qeRJH1I+NY92At0kehVxe1fd3LBStndIRX8
 QQTek1uERuk2mBv4EhFNn9f88iMR3V2I45ovMbhpRV7xgCkQ+yf75uA60UgPBDf/hPeB
 LY/8+/xxFqroe1EzM+EcGIME2VIzo26QApreGVj3qbzFEQVAZMnSemghSN3dtQP1N5/t
 5nNVZJNISCwL5iZUN2knPvR4Yj9KEEs+Sh/Qqe2BzQncdbt+E7+FtxoXVvtEXUat25n8
 KxTDR72847qNMShy7KTygefVIR9/AXF9XHHkB6XQHGA5PgaqUXyOK0LQUQ1woxM9xZV9
 XV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781968946; x=1782573746;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uyNBENQ7plqOT9m3LCX8AfT9Cl4ojA3Hc06FGUff6TM=;
 b=Z3KLVuQW+Xywg3+czYaHvqaKCKadhcWB/Oib+zHyx+v1rKga3jpG9lmSwN+OJy0vAK
 0E+pkItzdmUPwMGMCEWXlrjqennoykITXYif8QpH+tQWbrsKFq0gXYf7ilSUg1I6zAqG
 N+aQEtxOGfVn6H3MwakAt/41rc8tkR7joAqp/xv8O/LYw2uS1ZL7btKU+dLXpraCHcx8
 bEHwPOS9Tl6jKz75fQDcVfsiC/s7jB3BYVyQmlEN2Kyf/qljydAVshkRu9lGuKJcqgsW
 PZrG8pHP/xdGHH2m+6HMQ2p9Vary6bqONvOn3ja5DzvXEA/RyfBQqAGchWrHYdDC64rl
 PjTg==
X-Gm-Message-State: AOJu0Yy3Fc47VpRgSRjw7j7OZoSQPGyeGWfQza25MaMEgITeqBU1XTWT
 g1dThycFDArRwymt0AtzOI0X6kQACBeB2X2n8FCe+Vuar924qf5WJm2iE5SsJtVPvdm2QaOFkYN
 DQRWxpGt5ujkxGpIs9MtK5tVtfIl2ma166pmI2ktpxKwkGkQIUCSVcuql
X-Gm-Gg: AfdE7ckIC456qhEPOOGtsMVQj6nLCIpug601c7pSM2lBU8hAOLFB22X4oN6CQr/EuaY
 DXTLbi9Uh7go9EzePvMcWrBOkMvWWEfVuSwuksqOBcy+MoX9plOTX7tnQWgzM1NbcM2AlwxMJ09
 Y2O9IOK58XkXwI9Kvm6PcTNdRkBswxGHjWLWUDCeBbkGcZgHNWZWLJs/p2u4y7LA/T7G65EeYC5
 2G5TnxoGTkPeS44tqxJjpWH6HUtwVP9ApP/VGgKGgzicgrCzrxnG82KDPQBNreDjsIz6JTfRwfb
 J/NrONsWeP7foTlzcPQQG05O3ST/G/T99EQZK4LKi3K2Nio6F5klWpDxOmrjWJ80PQBwhFUj66I
 YGRV6jW052agWTgR1JhJNsg39KeNRZ53C4YDe0e/llA==
X-Received: by 2002:a05:600c:c088:b0:492:2e1c:1d19 with SMTP id
 5b1f17b1804b1-4923f597776mr127584265e9.31.1781968946698; 
 Sat, 20 Jun 2026 08:22:26 -0700 (PDT)
X-Received: by 2002:a05:600c:c088:b0:492:2e1c:1d19 with SMTP id
 5b1f17b1804b1-4923f597776mr127583915e9.31.1781968946244; 
 Sat, 20 Jun 2026 08:22:26 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-162.red.bezeqint.net.
 [79.177.155.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm69736475e9.9.2026.06.20.08.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 08:22:25 -0700 (PDT)
Date: Sat, 20 Jun 2026 11:22:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH v2] security: rework guideline about issue URL /
 CVE references
Message-ID: <20260620112214-mutt-send-email-mst@kernel.org>
References: <20260619091508.1194994-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260619091508.1194994-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 10:15:08AM +0100, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> In v2:
> 
>  - Use non-existing issue number as example
>  - Mention both issue URL and CVE to be optionally included
>    in all commit messages in a series
> 
>  contribute/security-process.md | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/contribute/security-process.md b/contribute/security-process.md
> index c091fa1..0ec1952 100644
> --- a/contribute/security-process.md
> +++ b/contribute/security-process.md
> @@ -92,19 +92,28 @@ be scrubbed before disclosure.
>  
>   * The maintainer(s) will develop and/or review patch(es)
>     for the issue privately, optionally attaching work in
> -   progress fixes to the GitLab issues. All patches must
> -   include the issue URL in the commit message(s). The
> -   **"Workflow::In Progress"** label should be assigned when
> +   progress fixes to the GitLab issues. The
> +   **"Workflow::In Progress"** label can be assigned when
>     a maintainer starts working on a fix.
>  
>   * When a CVE is allocated, it must be recorded as a comment on
>     the GitLab issue, and the **"CVE::Required"** label replaced by
>     the **"CVE::Assigned"** label.
>  
> - * The maintainer(s) will update the commit message(s) to include
> -   the assigned CVE and issue URL. If multiple commits are required
> -   to fix an issue the CVE must be included in the final commit in
> -   the series, and may optionally be included in all prior commits.
> + * The maintainer(s) will update the commit message(s) before
> +   sending a pull request to include the assigned CVE and issue
> +   URL in the following format:
> +
> +     ```
> +     Fixes: CVE-1980-12345
> +     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/42
> +     Reviewed-by: Not Me <notme@elsewhere.com>
> +     Signed-off-by: Some One <someone@somewhere.com>
> +     ```
> +
> +   If multiple commits are required to fix an issue the CVE & issue
> +   URL must be included in the final commit in the series, and may
> +   optionally be included in all prior commits.
>  
>   * When the maintainer(s) are satisfied that the patch(es) are
>     suitable to propose for merge, they must be submitted to
> -- 
> 2.54.0


