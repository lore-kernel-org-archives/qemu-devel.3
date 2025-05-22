Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFC7C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI741-0006DA-13; Thu, 22 May 2025 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI73x-0006Cj-Ko
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI73v-0001nk-Ee
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747924701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkVXrIX6Fr4LuHoxpc9jQzHGjzON7TaxnyYfqaMqRtA=;
 b=Mzu3aC+Z6Drj/QcZs/N/miL8P3qAlbmWU//AU/L/FHSBfW63hvsZCiUbvcjtVIZwBem7+A
 AVwTJXesxaovtHXQEUMJIk8/DDLZUAAgIWeumNXRGx4eHMtdh8t0CbSWt2SrEf4HL/sWXH
 ok3yep9moHiZ7hF3TiJh+PgtwaaPAtg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-4wM4EUqYNFeon4xvkIUZxA-1; Thu, 22 May 2025 10:38:20 -0400
X-MC-Unique: 4wM4EUqYNFeon4xvkIUZxA-1
X-Mimecast-MFC-AGG-ID: 4wM4EUqYNFeon4xvkIUZxA_1747924700
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f8d3f48f35so79513456d6.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 07:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924700; x=1748529500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkVXrIX6Fr4LuHoxpc9jQzHGjzON7TaxnyYfqaMqRtA=;
 b=JuyBnEFrOnjUizTXsUw3HdCR+HLiA7oK9NmuNO2eQh38DCyCJArQIrGuhroJhvbm/a
 w8mkKTjezF+TiQHkNr4RluDPqjbItASLS5wKWLED37EClYMB1mn8oBmNi60T/yyfFOX6
 FwsYhHgHYKwBX4IB3njNA4gVUeWONtRFt6Nnig+v2Nwq8og0stICjyg7j1FfySL4if0E
 KxK/T2DQJU7tr+mBsnsOTD0qv4L4NODsbKUicAlJ5J9ThuLNqEMyfQof1WviNgHta54r
 ZECqbNM1v8T/C5isSjKN2efLQqHAZThc5EBgy44iW4TEy0yrHB5Ntm0gqx+gXcd4ncN8
 DOXQ==
X-Gm-Message-State: AOJu0YyYL+Hwrv9kAvo+TWHu+H/Lg/Dn0bEZ8jgjRTkX3GVe450kU4bF
 UK+yiM1C0XCQQc8JlQE01flGJrFj2FUcFdZ6oqbKmmbAPLyAWdIg4iCw+3TY7pGUzpSWnkK7al8
 nIn25mc6hn/NaLP9KTrZ5I+q0yKKnOXSIBSS9oYj+JG1BNvfZO5xmMS6S
X-Gm-Gg: ASbGncsMjm53c5LzCDLtBX03LrXUKFoTNvAzUJEMOl2GPgXhWF4q7nspIlhWL+viZ+8
 LndLMkym3SegYWwYO5cWQ6tq7U8GSFRBu1YBI5mBMVKybqyhqYlYBqasEBdP4KfnI9iUdPa4KHF
 JArIFydPZ4VwLyT4gw2Te3Q5dh3dwdV8LDKQ70l8Ax6MvnbyTD7bGZvCv4AGOwF2VsUosk3dFqu
 zZHKsgkJuHzNvdCAi9w2G9FwJyrGs9sXPYV/wPyhoiIFok8ywzI8zVmASl+tclV8wbi7VXIAmgE
 yyU=
X-Received: by 2002:a05:6214:d83:b0:6f8:d223:3c4a with SMTP id
 6a1803df08f44-6f8d2233eb2mr261231436d6.17.1747924699735; 
 Thu, 22 May 2025 07:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY6NFdgb3Vqfx8pb5JZRqsI+gFdRB7j2eolPA7OZiANw62unyNsoJ4QoTdF5ROuC9XVHnDIA==
X-Received: by 2002:a05:6214:d83:b0:6f8:d223:3c4a with SMTP id
 6a1803df08f44-6f8d2233eb2mr261231186d6.17.1747924699315; 
 Thu, 22 May 2025 07:38:19 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0898f66sm100661206d6.27.2025.05.22.07.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:38:18 -0700 (PDT)
Date: Thu, 22 May 2025 10:38:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 3/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Message-ID: <aC820hzwtrFBV9oq@x1.local>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522133756.259194-4-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 22, 2025 at 03:37:55PM +0200, Thomas Huth wrote:

[...]

> +    def test_vmstate(self):
> +        target_machine = {
> +            'aarch64': 'virt-7.2',
> +            'm68k': 'virt-7.2',
> +            'ppc64': 'pseries-7.2',
> +            's390x': 's390-ccw-virtio-7.2',
> +            'x86_64': 'pc-q35-7.2',
> +        }
> +        self.set_machine(target_machine[self.arch])
> +
> +        # Run QEMU to get the current vmstate json file:
> +        dst_json = self.scratch_file('dest.json')
> +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
> +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
> +                             '-M', target_machine[self.arch],
> +                             '-dump-vmstate', dst_json],
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            text=True)
> +        if cp.returncode != 0:
> +            self.fail('Running QEMU failed:\n' + cp.stdout)
> +        if cp.stdout:
> +            self.log.info('QEMU output: ' + cp.stdout)
> +
> +        # Check whether the old vmstate json file is still compatible:
> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> +                                  self.arch,
> +                                  target_machine[self.arch] + '.json')
> +        self.log.info('Comparing vmstate with ' + src_json)
> +        cp = self.run_vmstate_checker(src_json, dst_json)
> +        if cp.returncode != 0:
> +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)

Would false positives happen here?  Would it fail "make check" and CI, even
if the change was intended?

> +        if cp.stdout:
> +            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> -- 
> 2.49.0
> 

-- 
Peter Xu


