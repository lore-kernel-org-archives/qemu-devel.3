Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B3AD1266C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQWRN-0002op-5C; Tue, 02 Dec 2025 14:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vQWRM-0002nh-6u
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vQWRJ-0006fa-Bp
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764705212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qRiNcCNBjrG5HCq6gQ1dLXxLIJ0/SIxRa90UqAduo2M=;
 b=CjCIhRqwL94E33QHR3oS0m6PN8ydCkY38qv049fE63b0Lb7NK7stSSO9NiN8hKhUswNBuV
 BSNv5s+mBLTu4c68c3nO73pt9pjeDGruAKq2V4tV5PcilizvRtSllLJ93ZlqLmF7LhaGrZ
 xvkr70dbi5R+HVVj+Os+sHOod/OWwbo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-CfZtgNICOnmSh1KztPFmSg-1; Tue, 02 Dec 2025 14:53:31 -0500
X-MC-Unique: CfZtgNICOnmSh1KztPFmSg-1
X-Mimecast-MFC-AGG-ID: CfZtgNICOnmSh1KztPFmSg_1764705210
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-64165abd7ffso7319947a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764705210; x=1765310010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qRiNcCNBjrG5HCq6gQ1dLXxLIJ0/SIxRa90UqAduo2M=;
 b=H2tEhuZCon2AB5bdVCrDwoiWcKSYEE6bF6v3aLD2ECRhnyWY+wJoKrgVg1PDctC+Nx
 uAn4iGiYMucai8WnG/0JNypFciFeYFjadif1ji7txZ0eEvgylXVYSh/uPDbwOleI4Mfq
 AKzW1DcZM7dxH1EVJNX0KRSodlDuouLLTtcGyb3dS0v6FEBbCKyRTQJXakKnoAoXByvX
 KjQzjfcaxlKRLj/pkyr8BOgyONgsZlrHDMYc20lTHJwSGY68tmjv3fa5GBGu1bn9Dwft
 qJtk/E7s9/ZbHkmko0+fOGssu8yC5jJ7Qp4JD+NdWbEghozMWo1Wu4Y7zelMARuxrw+L
 VTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705210; x=1765310010;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRiNcCNBjrG5HCq6gQ1dLXxLIJ0/SIxRa90UqAduo2M=;
 b=LhGczGyhAjdbU9nXju0C5MxDCVDHRjZ+eaYxgxMDSoVOQSLS/jX9dzjQtmANa4x5d2
 hvj91EcmB42droLJzybiPC91NjEiDMsXn6ej8jFM2+amk527R4xsz9PakXkeKe3tpa2p
 EebYJflW0D2xmw8m3WhH1MJ7qTwWfcwOn7hgn3jklYq2PtxZZJid4ODXkLkpx61PZkXX
 U8YYEGT3/eE966w5R4+diHIJ5HNky/1xpcK156PcTFMfcAvlVvZPBO4aWp270PltL83A
 8nG2ANuVBDQRkFDksIYzXj/hxa07QQH2UPyQe86dG9wXYCVVEPv+sA1VWj2Xm38BRAm9
 qqYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTmrHMOlBb46ujblJ2OqOesLuH500pfV2PHTvThfByrh9Y0b0+U/llHvHQYCKfRRTGKXCyIwR8WXua@nongnu.org
X-Gm-Message-State: AOJu0YwZvWuguT8AWsE0XUzDgN37AUYzzFmQGsDRFehuHB0lebnKFIfD
 hJE5ZD/ZAI+wnq/oOdknOij/tyi7TE+ngimfVXz63WVEU4DivmVf+KOgid/isAE1i/saYqgOxT+
 l6OSrcnnWbap2j4HB9BYnZtzPalTRYL/FQ70/KFTG1db1Jv5TBrNYgHTD
X-Gm-Gg: ASbGncukpuunYIVsh5poUKTwenWE95usUenT1qJLkJit0dsZcrinnlqLLdbnXsl8v4t
 190YOL68uozHduIaMFKkxrazzi3s71+ddzRgshFC4iiPZ+DKm7HtgA0a+rqwQx6ZZwvH9758lhe
 xpIQ6QGtNDQNL985KRpNfh/RvRAEapTtFsM7h2mKY5TOOGP5vx081l+YDhzraNl1pVgmYXrVCR/
 p3M6EBniBGW0yt1dQOvIF2acdJWr8K+jusvMJfJf62qwEbMwsYlq9WFW54ViNZs//FlmWJxVtUD
 EwCmekD/l5+RGnlUflX549Vs0z/pFBnWpeDh1KxsQV1TA/oLIF8FrGjpgd4J6v/Env/mw5X4A1N
 plmYhcA==
X-Received: by 2002:a05:6402:520c:b0:640:825e:ae82 with SMTP id
 4fb4d7f45d1cf-64554677479mr37545516a12.29.1764705209994; 
 Tue, 02 Dec 2025 11:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFZ1ZjEW8Ukjj2PVzvFspvRpbFchgWKJBuwn+yzEXSecasPeNO7+meB8NknchLD8+772tUsw==
X-Received: by 2002:a05:6402:520c:b0:640:825e:ae82 with SMTP id
 4fb4d7f45d1cf-64554677479mr37545505a12.29.1764705209613; 
 Tue, 02 Dec 2025 11:53:29 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.41]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035c3bsm16062308a12.19.2025.12.02.11.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 11:53:29 -0800 (PST)
Message-ID: <47138433-8a81-4a7e-8ce0-b96211df5ef0@redhat.com>
Date: Tue, 2 Dec 2025 20:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/9pfs: Correct typo
To: AlanoSong@163.com, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20251202132132.17636-1-AlanoSong@163.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251202132132.17636-1-AlanoSong@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/12/2025 14.21, AlanoSong@163.com wrote:
> Correct comment typo in xen_9pfs_bh()
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>   hw/9pfs/xen-9p-backend.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 79359d911a..ca0fff5fa9 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -310,7 +310,7 @@ static void xen_9pfs_bh(void *opaque)
>   
>   again:
>       wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
> -    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
> +    /* paired with the smp_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
>       smp_rmb();
>       if (wait) {
>           cpu_relax();

Reviewed-by: Thomas Huth <thuth@redhat.com>


