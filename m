Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4354C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tplU5-0004Lg-7C; Wed, 05 Mar 2025 04:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tplU3-0004LD-R7; Wed, 05 Mar 2025 04:56:11 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tplU1-0007D5-Qi; Wed, 05 Mar 2025 04:56:11 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fd89d036so2230005ad.1; 
 Wed, 05 Mar 2025 01:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741168567; x=1741773367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tzy3UH7UzkMEGdBhjgDNFmclNQWzRn0iUNq7DiTDGJI=;
 b=Zda2QNDFIurtoskIHu2OUmdJwb3Jqj9QvKpwa5zYOlVrwXAZiOxf9rNsFD6mEPRdnT
 o1YCt1b52iBYeC4eMQUwDtz/tx6QQ59gS/yZ3jHyZvT59gc0m/Gc1j5BiH/DRQsD+vuZ
 Y3e4XjN9ZCg6TvjI43+GHeKS7wcgU54VvR2KtOdu6+tK8sFrI0F0IOWZPoIIfDFgzgsk
 qEfBdzpb6JtA/qiTLJ1CSTp+/l0h3IOYQ0CuyP5eGMVq8Cq4nzj9vXcBqlu9QCbqQAVH
 xCKB+P19QPAEdgSNE+OcgJZZTyZ0COrp+n/lc8gm+Zk9/WB12fWcQ7tO1vTvEiLqkB9e
 G1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741168567; x=1741773367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tzy3UH7UzkMEGdBhjgDNFmclNQWzRn0iUNq7DiTDGJI=;
 b=a3INS4Lcsc3FjtshjlaiR5JxAEvDGa/COvMOAmmKy2uuPiCMjplRoG3MGdxFSXGHaZ
 v37Ru79Vk80cLh2W2WWYY8ubqHQIwvNJnVbaifEn3Nux4NdtuKzRN6JfAopaVjknlLoC
 h2gRmyQWEM7v/bphF9rS7hKDavOTzJTmLcpxqfwsEjsA2LMri2+8f5OKurTqOmtHsw74
 Sv155Eqwv1twH66xJ1DJhBrmtr5odHMncqcsoxYQV5sk8t3KsbpSYRIFxeakKsRiOwyF
 AtDgiZI9gk/yCD5R7PfvOFB+bchvRQ1o4GVdrfQslbIWNv3kHsu0t2TV31vO2tHllUXl
 DhEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCQooTA1mA2fA7wFArvGEyEzu7vw/geshjgieloYpA1LF+EAEGeS6Z80Xz8aDIbJ1kXQYv3FH1GNyX@nongnu.org,
 AJvYcCXXRcQFR1C2NV/qLwtI4KK/bRNnZOXdtvtrIkrWIlci7YN2PZkSEczRY29lnEe3bl6iCheA1xj488ba@nongnu.org
X-Gm-Message-State: AOJu0YzzOq1DeNNDWO9/0ApNWfe5jjY/MykAMsszZPkUEhCe18CP1BeB
 ag+7BLpqhT8/zDjrwEVq/JdBafKcIoPDPPfkmZa3Kus20hHXvPCiNGvL7tNT
X-Gm-Gg: ASbGncuhoTZCwypFdSEu1W4SqoTCjWdoAnWA6ZqdEnX4wN9qX6gLs344LafwoxyQ3Dz
 R3v8HIH7e796vty+kPRRSrtynuTX70IU/4NST1gk2LfH8cSU3C5sJMM3EJzMiyXi9cWYr9JHznf
 4oj29cALcq+XYn1JgjIyD6PFrZ4iVpHIif4vnJfcJujQgbFzExKRdZ3agyNnmI4ZaDoSt+1ijUZ
 S4Mw8psXpA3pC+HMV804n3txROErAcbQqU1xLc0ZUkgBKCKcjurf+QcA6mapPVVT6mlwsl7mofv
 QM1+ZPmornZ73gUO+3zkbBaFK7ZCnhEMuDpqgcOrzWpX9j+0DfRiqKZarykyksM=
X-Google-Smtp-Source: AGHT+IEiWNpdAo/hQUgxWC8n3LIlDkMz+l4RILr7yPiCLXfM1loZPpMcH1nQ8y5XNMvWtZ9fu1jW6g==
X-Received: by 2002:a05:6a00:4b01:b0:736:5b46:489b with SMTP id
 d2e1a72fcca58-73682b55238mr4129139b3a.1.1741168566765; 
 Wed, 05 Mar 2025 01:56:06 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736550edf72sm5621776b3a.167.2025.03.05.01.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 01:56:05 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 17:56:01 +0800
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 09/11] rust/block: Add read support for block drivers
Message-ID: <20250305095601.GD247800@fedora>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ANoX1nAJAWeM9Fej"
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-10-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


--ANoX1nAJAWeM9Fej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 07:20:17PM +0100, Kevin Wolf wrote:
> +/// A request to a block driver
> +pub enum Request {
> +    Read { offset: u64, len: u64 },
> +}
> +
> +/// The target for a number of guest blocks, e.g. a location in a child =
node or the information
> +/// that the described blocks are unmapped.
> +pub enum MappingTarget {
> +    /// The described blocks are unallocated. Reading from them yields z=
eros.
> +    Unmapped,
> +
> +    /// The described blocks are stored in a child node.
> +    Data {
> +        /// Child node in which the data is stored
> +        node: Arc<BdrvChild>,
> +
> +        /// Offset in the child node at which the data is stored
> +        offset: u64,
> +    },
> +}
> +
> +/// A mapping for a number of contiguous guest blocks
> +pub struct Mapping {
> +    /// Offset of the mapped blocks from the perspective of the guest
> +    pub offset: u64,
> +    /// Length of the mapping in bytes
> +    pub len: u64,
> +    /// Where the data for the described blocks is stored
> +    pub target: MappingTarget,
> +}
> =20
>  /// A trait for writing block drivers.
>  ///
> @@ -37,6 +72,11 @@ unsafe fn open(
> =20
>      /// Returns the size of the image in bytes
>      fn size(&self) -> u64;
> +
> +    /// Returns the mapping for the first part of `req`. If the returned=
 mapping is shorter than
> +    /// the request, the function can be called again with a shortened r=
equest to get the mapping
> +    /// for the remaining part.
> +    async fn map(&self, req: &Request) -> io::Result<Mapping>;

Here are my thoughts about how the interface could evolve as more
functionality is added (beyond the scope of this patch). I'm sure you
have your own ideas that aren't in this patch series, so take it for
what it's worth.

The main point:
The current interface has Request, which tells the BlockDriver that this
is a Read. I think this interface is still based on I/O requests rather
than being about mappings. The caller should handle
read/write/discard/etc request logic themselves based on the mapping
information from the BlockDriver. Then the BlockDriver just worries
about mapping blocks rather than how to treat different types of
requests.

A sketch of the interface:
The interface consists of fetch(), alloc(), and update().

1. Fetch mappings located around a given range:
   fetch(offset, len) -> [Mapping]

   The returned array of mappings must cover <offset, len>, but it can
   also be larger. For example, it could return the entire extent that
   includes <offset, len>. Or it could even contain the <offset, len>
   mapping along with a bunch of other mappings.

   If the BlockDriver pays the cost of a metadata read operation to load
   mappings, then let's report all mappings even if they precede or
   follow the <offset, len> range. The exact amount of extra mappings
   reported depends on the BlockDriver implementation and the metadata
   layout, but in qcow2 it might be an L2 table, for example. The idea
   is that if the BlockDriver volunteers extra mapping information, then
   the caller can perform future operations without calling into the
   BlockDriver again.

   If it turns out that certain BlockDriver implementations don't
   benefit, that's okay, but let's include the flexibility to volunteer
   more mapping information than just <offset, len> in the interface.

2. Allocate new unmapped blocks:
   alloc(num_blocks) -> Result<(BdrvChild, Offset)>

   (A choice needs to be made whether the blocks are contiguous or not,
   I'm showing the contiguous function prototype here because it's
   simpler, but it could also support non-contiguous allocations.)

   These blocks are not mapped yet and the caller is expected to write
   to them eventually, populating them with data.

   I'm assuming the qcow2 crash consistency model where leaking clusters
   is acceptable here. Not sure whether this API makes sense for all
   other image formats, but please bear with me for the final part of
   the interface where everything fits together.

3. Update mapping:
   update(offset, len, MappingTarget) -> Result<()>

   This adds or changes mappings. It's the most complicated function and
   there are a lot of details about which inputs should be
   allowed/forbidden (e.g. creating completely new mappings, splitting
   existing mappings, toggling MappingTarget on an existing mapping).
   Perhaps in practice only a few valid combinations of inputs will be
   allowed rather than full ability to manipulate mappings.

   Anyway, here is how it can be used:
   - Allocating write. After blocks allocated with alloc() have been
     written with data, call update() to establish a mapping.
   - Discard. Change the MappingTarget of an existing mapping to unmap
     blocks. This frees blocks unless they should be anchored (aka
     pre-allocated).
   - Write to anchored blocks. If the mapping had blocks allocated but
     they were not mapped, then update() should be called after data has
     been written to the blocks to restore the mapping from anchored to
     normal mapped blocks.

The overall idea is that I/O requests are not part of the interface,
only mappings. The caller decides how to perform I/O requests and calls
the appropriate combination of fetch(), alloc(), and update() APIs to
ensure the necessary mapping state is present.

It will probably be necessary to add additional mapping information
indicating permissions, compression/encryption info, etc so that the
caller can process I/O requests rather than sending them into the
BlockDriver.

Stefan

--ANoX1nAJAWeM9Fej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfIH7AACgkQnKSrs4Gr
c8g8GQf+MjdHdx0XauT6RqNJaeZkTgPEVVl/dGqdcrNtMqmEeKYXqHAn2gmlcIB9
Nf4gXx9Ke/l0UeVpUWMBCh9//N5ivucYIRVkX+u+zezWKGJc+H91howVrRf/qyYR
mIuRo3sHKeQutaJkuFJbPhkYYpT0vBvWqHtKHgj9+KMQEgb24CHH8cqxyswI3TDT
iW3fAPEQzaKN5Os6eir1t1U68/8pz1Wp+FTCRGIiFwS+J1+0/IMXssgZtmL8ad0D
7lE1+ZAnOQZGCVfirNw1sYST+vAUsB19SiWdX7jGpWL6LSDxYm5+mCcoly6R6v6j
XSGjnWXNAXQIGgDWCLqpp7hLdAMOvw==
=w06F
-----END PGP SIGNATURE-----

--ANoX1nAJAWeM9Fej--

