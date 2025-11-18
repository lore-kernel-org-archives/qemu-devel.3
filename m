Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE2CCED25D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIUP-0008IZ-9l; Tue, 18 Nov 2025 04:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIUN-0008I4-Nb
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIUL-0004Wm-Ik
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763459944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BKC1EAYcOX5OqTcEkCnf78fRd2K8A9q9iJ/k485CL14=;
 b=bktFrWVw6lrmdKZ6dhuoTM5Y5BW8w2LDoT1iyo5iSZYZQIGSKpNwRzWJBu/M9fLwQ9ujLW
 M4prIVpWiGhIk1n5skbL7uJkkfDJdfq0rt25xqEKyY4pbrnynxrytM48zJrgH1r+w0+YR7
 uyOBBhyebN1+mYz8BPFhNHdskfOM8qM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-Ba3E8jVdMeG3cAYB5kr9Mw-1; Tue, 18 Nov 2025 04:59:02 -0500
X-MC-Unique: Ba3E8jVdMeG3cAYB5kr9Mw-1
X-Mimecast-MFC-AGG-ID: Ba3E8jVdMeG3cAYB5kr9Mw_1763459941
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b3155274eso2197094f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763459941; x=1764064741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BKC1EAYcOX5OqTcEkCnf78fRd2K8A9q9iJ/k485CL14=;
 b=AN875Le4D0CAU9ruBcgzDRSw/rdAZd/btkTB+biWDTq1raipbWKPc1xh0vJVdYfT1D
 0Wf5EDpfEfZYBYM7KiAZ88yPi94/cHFSJ2kw4naaW990EAVYKaLqd1huiGOtIFSouYqk
 3klcRUBrcTt7ROsl41VPAxkTZ92+GcQuprQ2/LdTkcUYwLZArBaLzfAyS+z9jVfyqUuo
 3W4DkZUqSCz2+m4FQ8sjenA3ICqDGOlkWSR7XAGjVgS+quRehKzKUZ/uH6vlki+YTyhg
 Snrz/lFRJ+I1Jok0dM7ng5nUvO80E5OXS0ytH5CtCSmUBvTMEKfcuRY5o+WL6z5qHTfr
 PNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763459941; x=1764064741;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKC1EAYcOX5OqTcEkCnf78fRd2K8A9q9iJ/k485CL14=;
 b=uDpt1OqXfa4ZCxWFG0HcXx35wIYdPTJDStVBY2QQD0D8R3GJRmKeMVFBc8IBDPMjZQ
 PIpUc2nPTb92Y42m9l6C+PwEKr1QMOTMkO/CFHVmMdN8KAfSeeGX5mAas2yd9aJN93lT
 M7a5L5khrP5uS3FINvblXKlhTv4yx1YlD/0bmKYjBmNIAnMzaUR5ivpIK+4/ADWV0oO7
 SQzEUf9cHthE0lFA+zezsbk5XAC9Zrv86zvTC0yoZfSG0ic/BX1zFratapt5MaZzOdu6
 j/XMXqGUmDmZsQpXRxS9g9uWHo6E4B7xphjxzCOme935MuRlpSH2TRvVFjLJB7o+scSf
 vjxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe0XQqD/bmJRLqUuwm62KTANUQrJMrHWQMpbVbS2zzalyMWHQPQV8tftURSjS5Z3mLegXmLUwBZ88y@nongnu.org
X-Gm-Message-State: AOJu0Yw6M0oJJ6DOR+eWLTd9UebKxSixwQ+AlQyvvbaGZQPhYS/yNGLO
 M2xpI7HRsULvIrfIRWjDHu6131x4nvAiwxO4w6qoRgECKFpmvzEsecYjr983DCQBo2VUabh3Mu9
 WYAbuUhixAHgfGWrXaMNbiYvM29JlzQ8q7j3+dBH6pbVVqSA2fR/oj2zv
X-Gm-Gg: ASbGnculwr3XuLdXcoXzJjQdEL1jrG6pi7GMlqxM5kujmHteAGeGHEu+FTUcEKYqPRO
 cmVfLYKf6qcb67YMUSJrIoLlRdmAyagwXD/9zz9zDWvTxdyrQEuM86UxM89ts31DYJNT+1jtaU5
 /8bp4qKz+kDPfG6UTT/ewuzuaDBkzUvca/nrKVRYLmYki96NCtqnd0wQZPDRQakFP8XTrP9WwU5
 uJAMCUhmN3s/9RM3+mxwoZbkvyl0+JLfZJbV7sjlv3K4dpqXgk2cMm0bzSEf/MSSoyYWzY3ljqW
 jPKy8S4KgnAnws61aNGa5DbfNZGbc70tz/h4emutMVFhlBR4XyzaLSMRSTJ1tONXI+0/5vLB7EA
 J1e8Y2as=
X-Received: by 2002:a05:6000:2dc3:b0:42b:3e0a:64af with SMTP id
 ffacd0b85a97d-42b5935e266mr13777831f8f.11.1763459941193; 
 Tue, 18 Nov 2025 01:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZEyow485z+6a/aPcARBO8h8TuSYXHtNMofMgt4yIh2kxh9wwq18CJIyBMgovdJ8gar6x2wA==
X-Received: by 2002:a05:6000:2dc3:b0:42b:3e0a:64af with SMTP id
 ffacd0b85a97d-42b5935e266mr13777807f8f.11.1763459940807; 
 Tue, 18 Nov 2025 01:59:00 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f2084dsm31823079f8f.42.2025.11.18.01.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 01:59:00 -0800 (PST)
Message-ID: <cf1569a9-6258-44a2-91ad-f5760c8ed8b8@redhat.com>
Date: Tue, 18 Nov 2025 10:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] tests/iotests: use "make check-venv" to prepare for
 running iotests
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-11-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-11-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/11/2025 19.51, John Snow wrote:
> Soon, qemu.qmp will not be included in the qemu.git tree and so invoking
> the meson target for preparing the "checktests" mkvenv group will be
> necessary for this test to run successfully. Doing it now in its own
> patch separates this change from the big switcheroo patch.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index c3a9e8428c2..18d72d3058b 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -350,6 +350,7 @@ build-tcg-disabled:
>       - make -j"$JOBS"
>       - make check-unit
>       - make check-qapi-schema
> +    - make check-venv
>       - cd tests/qemu-iotests/
>       - ../../pyvenv/bin/python3 ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163

Reviewed-by: Thomas Huth <thuth@redhat.com>


